# Kubernetes Cluster Installation

This directory contains the commands necessary to deploy Kubernetes clusters. each with a different container networking interface (CNI) provider.  While the primary focus of this repository is to focus on Cilium (itself a CNI) based Kubernetes (K8s) clusters, we are also providing different K8s clusters using alternative CNIs in order to showcase their different behaviors as well as to demonstrate the [Istio Service Mesh](../../istio/README.md).

## Overview

Each cluster deployment described here is built with the [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) toolbox. The [dcloud pod](../terraform/README.md) that has been built has all the pre-requisites installed using [Ansible](../ansible/README.md) and then "saved" within the dCloud environment.  This saved template is then used to generate the K8s cluster variations.

The general flow for installing the Kubernetes clusters, regardless of the CNI leveraged, is:

1. Start the dCloud instance
2. Run the cluster install script on the control plane node
3. Run the cluster join script on the worker nodes
4. Install the CNI
5. Deploy a sample application to validate a working cluster.
6. Remove the application
7. Save the dCloud session

## 3rd-party CNI clusters

The following 3rd party CNIs have Kubernetes cluster instructions provided:

- [Weave CNI](./weave/README.md)
- [Calico CNI](./calico/README.md)
- (incomplete)[Flannel](./flannel/README.md)

## Cilium Cluster

As with any Kubernetes cluster installation, there are two components: the control plane and the worker/compute nodes. The scripts are for lab purposes only and disregard the discovery token hash (sha256 string).

You can manually copy the join command after running the [01-install-cluster.sh](./01-install-cluster.sh) and use it instead of running the [02-join-nodes.sh](./02-join-nodes.sh) contents.

## Pre-requisites

The node deployment and OS pre-requisites must be set up prior to running the kubeadm commands.  Typically, those steps will install the required kubeadm command as well so you'll know fairly quickly if you forgot.

This deployment and configuration setup is handled by [ansible](../ansible/README.md)

### Local workstation Tools

```bash
brew install kubectl
brew install helm
```

## Control Plane Setup (single node control plane)

On the control plane node (k8s-control-1), either run the script (if you've cloned the repo) or cut and paste its contents into the CLI on the control plane node:

```bash
# Run kubeadm and copy kubeconfig to user home directory
source 01-install-cluster.sh
```

## Worker Node Joins

```bash
### Run kubeadm join commands
source 02-join-nodes.sh
```

## Copy kubeconfig to local workstation

```bash
### Logout of 198.18.129.20

### Copy new Kubernetes cluster admin KUBECONFIG file
scp -i ../ansible/k8s-cluster root@198.18.129.20:.kube/config kubeconfig-cilium
export KUBECONFIG=$PWD/kubeconfig-cilium
```

## Deploy Cilium

Only perform this step if you want a full featured working cluster.  Otherwise, go to [Cilium Demo](../../cilium/README.md) for instructions on demonstrating the Cilium components.

```bash
source 03-deploy-cilium.sh
```

## Deploy MetalLB, Cluster local load balancer

```bash
source 04-deploy-metallb.sh
```

## References

- [Beware Cilium's default pod CIDR](https://medium.com/@isalapiyarisi/learned-it-the-hard-way-dont-use-cilium-s-default-pod-cidr-89a78d6df098)
- [Cilium Cluster Scope IPAN](https://docs.cilium.io/en/stable/network/concepts/ipam/cluster-pool/)
- [Create Local Cluster and Load Balancer](https://dzone.com/articles/how-to-create-a-kubernetes-cluster-and-load-balanc)