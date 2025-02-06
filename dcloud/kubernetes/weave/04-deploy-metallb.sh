#!/usr/bin/env bash

# Set up MetalLB as a L2 loadbalancer so that applications can be reached via the pod VPN
kubectl create namespace metallb-system
kubectl label namespaces/metallb-system \
    pod-security.kubernetes.io/enforce=privileged \
    pod-security.kubernetes.io/audit=privileged \
    pod-security.kubernetes.io/warn=privileged

helm repo add metallb https://metallb.github.io/metallb
helm upgrade --install --namespace metallb-system metallb metallb/metallb

# Alternatively, you can use a simple version specific installation YAML file:
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml

# Configure the MetalLB instance for L2 operation
kubectl -n metallb-system create -f ../metallb/metallb-l2-config.yaml
