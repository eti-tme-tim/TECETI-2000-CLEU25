## Pre-requisites

### dCloud Deployment

The node deployment and OS pre-requisites must be set up prior to running the kubeadm commands.  Typically, those steps will install the required kubeadm command as well so you'll know fairly quickly if you forgot.

### dCloud OS pre-requisites

This deployment and configuration setup is handled by [ansible](../../ansible/README.md)

### Local workstation Tools

```bash
brew install kubectl
brew install helm
```

## Control Plane Setup (single node control plane)

On the control plane node (k8s-control-1), either run the script (if you've cloned the repo) or cut and paste its contents into the CLI on the control plane node:

```bash
# Log into k8s-control-1
ssh -i ../../ansible/k8s-cluster root@198.18.129.20

# Run kubeadm and copy kubeconfig to user home directory
source 01-install-cluster-weave.sh
```

## Worker Node Joins

```bash
# Log into k8s-control-1
ssh -i ../../ansible/k8s-cluster root@198.18.129.20

### Run kubeadm join commands
source 02-join-nodes.sh
```

## Copy kubeconfig to local workstation

```bash
### Logout of 198.18.129.20

### Copy new Kubernetes cluster admin KUBECONFIG file
scp -i ../../ansible/k8s-cluster root@198.18.129.20:.kube/config kubeconfig-weave
export KUBECONFIG=$PWD/kubeconfig-weave
```

## Deploy the CNI

```bash
source 03-deploy-weave.sh
```

## Deploy local cluster loadbalancer

```bash
source 04-deploy-metallb.sh
```

## References

- [Weave Net 2.8.1 Release](https://github.com/weaveworks/weave/releases/tag/v2.8.1): project archived but [Weave Kube Addon docs](https://github.com/weaveworks/weave/blob/master/site/kubernetes/kube-addon.md#-installation) still available.
