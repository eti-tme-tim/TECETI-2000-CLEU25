#!/usr/bin/env bash

# Install experimental Gateway API CRDs to fix known issue, REQUIRED BEFORE cilium operator deploys!
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/experimental-install.yaml

# Add Cilium chart repository
helm repo add cilium https://helm.cilium.io/

# Deploy Cilium with Hubble, Prometheus, Grafana, and Ingress
export API_SERVER_IP=198.18.129.20
export API_SERVER_PORT=6443
helm upgrade cilium cilium/cilium --version 1.16.5 \
    --namespace kube-system \
    --install \
    --set kubeProxyReplacement=true \
    --set k8sServiceHost=${API_SERVER_IP} \
    --set k8sServicePort=${API_SERVER_PORT} \
    --set hubble.relay.enabled=true \
    --set hubble.ui.enabled=true \
    --set prometheus.enabled=true \
    --set operator.prometheus.enabled=true \
    --set hubble.enabled=true \
    --set hubble.metrics.enableOpenMetrics=true \
    --set hubble.metrics.enabled="{dns,drop,tcp,flow,port-distribution,icmp,httpV2:exemplars=true;labelsContext=source_ip\,source_namespace\,source_workload\,destination_ip\,destination_namespace\,destination_workload\,traffic_direction}" \
    --set envoy.enabled=true \
    --set l7Proxy=true \
    --set gatewayAPI.enabled=true \
    --set ingressController.enabled=true \
    --set ingressController.loadbalancerMode=dedicated \
    --set ingressController.default=true \
    --set loadBalancer.l7.backend=envoy \
    --set ingressController.hostNetwork.enabled=false


