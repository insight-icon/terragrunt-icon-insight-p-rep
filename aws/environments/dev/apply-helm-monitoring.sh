#!/usr/bin/env bash
set -e

echo "Updating kubeconfig..."
aws eks --region us-east-1 update-kubeconfig --name icon-svcs-cluster

echo "Adding tiller account..."
kubectl apply -f k8s/tiller-config.yaml

echo "Initializing Helm..."
helm init --service-account tiller --history-max 200

echo "Waiting for Helm to be ready..."
sleep 15s

echo "Updating Helm..."
helm repo update

if [ ! -d "k8s/consul-helm" ]; then
  echo "Consul chart doesn't exist..."
  CONSUL_GIT_VERSION=$(curl --silent "https://api.github.com/repos/hashicorp/consul-helm/releases/latest" | jq -r .tag_name)
  echo "Cloning" "$CONSUL_GIT_VERSION" "into k8s/consul-helm..."
  git clone git@github.com:hashicorp/consul-helm.git k8s/consul-helm
  (cd k8s/consul-helm && git checkout tags/"$CONSUL_GIT_VERSION")
fi

echo "Installing Consul chart..."
helm install k8s/consul-helm --name icon-k8s -f k8s/consul-k8s-config.yaml

echo "Installing Prometheus Operator..."
helm install stable/prometheus-operator --name icon-prom -f k8s/prom-op-configs.yaml

echo "Installing NGINX ingress controller..."
helm install stable/nginx-ingress --name icon-ingress --set controller.metrics.enabled=true --set controller.stats.enabled=true --set controller.metrics.serviceMonitor.enabled=true --set rbac.create=true --set controller.publishService.enabled=true

echo "Configuring ingress controller..."
kubectl apply -f k8s/ingress-nginx.yaml

echo "Done."