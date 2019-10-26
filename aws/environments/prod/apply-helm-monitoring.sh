#!/usr/bin/env bash
set -e

echo "Updating kubeconfig..."
aws eks --region us-east-1 update-kubeconfig --name ServicesCluster

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
echo "Configuring Consul DNS..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
  name: coredns
  namespace: kube-system
data:
  Corefile: |
    .:53 {
        errors
        health
        kubernetes cluster.local in-addr.arpa ip6.arpa {
            pods insecure
            upstream
            fallthrough in-addr.arpa ip6.arpa
            ttl 30
        }
        prometheus :9153
        proxy . /etc/resolv.conf
        cache 30
        loop
        reload
        loadbalance
    }
    consul {
      errors
      cache 30
      proxy . $(kubectl get svc icon-k8s-consul-dns -o jsonpath='{.spec.clusterIP}')
    }
EOF


echo "Installing Prometheus Operator..."
# Pinned release to --version 6.14.1 because of https://github.com/helm/charts/issues/17839
helm install stable/prometheus-operator --name icon-prom -f k8s/prom-op-configs.yaml --version 6.14.1

#helm install stable/prometheus-operator --name icon-prom -f k8s/prom-op-configs.yaml --version 6.14.1 --set prometheusOperator.createCustomResource=false

echo "Installing NGINX ingress controller..."
helm install stable/nginx-ingress --name icon-ingress --set controller.metrics.enabled=true --set controller.stats.enabled=true --set controller.metrics.serviceMonitor.enabled=true --set rbac.create=true --set controller.publishService.enabled=true

echo "Configuring ingress controller..."
kubectl apply -f k8s/ingress-nginx.yaml

echo "Waiting for ELB to spawn..."
ELB_HOSTNAME=""
while [ -z "$ELB_HOSTNAME" ]; do
  echo "Waiting for end point..."
  ELB_HOSTNAME=$(kubectl get svc icon-ingress-nginx-ingress-controller --template="{{range .status.loadBalancer.ingress}}{{.hostname}}{{end}}")
  [ -z "$ELB_HOSTNAME" ] && sleep 10
done
echo 'End point ready:' && echo "$ELB_HOSTNAME"

echo "Creating DNS CNAME records for ELB..."
terragrunt apply --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir "us-east-1/network/svcs-elb-dns" -var elb_host_name="$ELB_HOSTNAME"

echo "Done."