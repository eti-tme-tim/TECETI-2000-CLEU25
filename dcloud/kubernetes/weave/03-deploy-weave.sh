#!/usr/bin/env bash
# This is a very basic CNI to leverage for now but, unfortunately, WeaveWorks and the project
# are now archived.

# Deploy Weave CNI
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

# Monitor deployment
kubectl -n kube-system get pods -w
