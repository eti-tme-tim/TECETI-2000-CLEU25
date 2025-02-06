#!/usr/bin/env bash
# These commands MUST be executed on the k8s-control-1 node
#
# pod network CIDR depends on the CNI configured value (or its defaults)
#     calico - defaults to 192.168.0.0/16
#     weave - now defunct - defaults to 10.32.0.0/12
#       - kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
#     flannel - defaults to 10.244.0.0/16
#     cilium - defaults to 10.0.0.0/8
#       - this can prove to be problematic in many networks, especially if node IP range is in 10.x

kubeadm init --service-cidr=172.31.0.0/16 --pod-network-cidr=10.32.0.0/12 2>&1 | tee ${HOME}/cluster-weave-install.log
grep -A1 'kubeadm join' ${HOME}/cluster-weave-install.log > cluster.join.sh

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
