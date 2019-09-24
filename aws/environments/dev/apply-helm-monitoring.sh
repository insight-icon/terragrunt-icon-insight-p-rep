#!/usr/bin/env bash
set -e

echo "Updating kubeconfig..."
aws eks --region us-east-1 update-kubeconfig --name icon-svcs-cluster

echo "Adding tiller account..."
kubectl apply -f k8s/rbac-config.yaml

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

echo "Installing Prometheus Operator"
helm install --name icon-prom stable/prometheus-operator -f k8s/prom-scrape-configs.yaml

echo "Done."