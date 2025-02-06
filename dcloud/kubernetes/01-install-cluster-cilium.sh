#!/usr/bin/env bash
# These commands MUST be executed on the k8s-control-1 node
#
# pod network CIDR depends on the CNI configured value (or its defaults)
#     calico - defaults to 192.168.0.0/16
#     weave - now defunct - defaults to 10.32.0.0/12
#       - kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
#     flannel - defaults to 10.244.0.0/16
#     cilium - defaults to 10.0.0.0/8
#       - this can prove to be problematic in many networks where upstream 10.x addressing may conflict
#       - in production networks, do something else
#       - Cilium automatically uses the provided pod-network-cidr because kubeadm adds --allocate-node-cidrs to 
#         kube-controller-manager when the cidr range is specified.

kubeadm init --service-cidr=172.31.0.0/16 --pod-network-cidr=192.168.0.0/16 --skip-phases=addon/kube-proxy 2>&1 | tee ${HOME}/cluster-cilium-install.log
grep -A1 'kubeadm join' ${HOME}/cluster-cilium-install.log > cluster.join.sh

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
