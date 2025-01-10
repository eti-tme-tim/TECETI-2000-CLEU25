# Ansible Configuration of dCloud Pod

## Commands

Setup and activate the Python environment

```bash
brew bundle install -f Brewfile.ansible
source setup.sh
```

Basic infrastructure setup of the nodes, such as hostname resets, /etc/hosts creation, etc.

```bash
ansible-playbook 00-pod-setup.yaml
```

Docker repo setup and installation on all nodes

```bash
ansible-playbook 01-docker-setup.yaml
```

Kubernetes repository setup and utility installation. No cluster creation!

```bash
ansible-playbook 02-kubernetes-setup.yaml
```

In the dCloud lab environment, we save the current state of the pod before proceeding to the different Kubernetes cluster creations.

Manual cluster creation (for now) is a manual step and found in [kubernetes](../kubernetes/README.md).


## References

### Kubernetes Setup
- [Kubernetes Container Runtime Setup](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
- [Kubernetes Cluster Creation with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
- [kubeadm token generation](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-token/)
- [Potential Ansible kubeadm setup](https://github.com/kairen/kubeadm-ansible)

### Helm/Application Setup
- [Helm Installation](https://helm.sh/docs/intro/install/)
- [Local Cluster Load Balancing](https://dzone.com/articles/how-to-create-a-kubernetes-cluster-and-load-balanc)
- [MetalLB Installation](https://metallb.io/installation/)
- [MetalLB Configuration](https://metallb.io/configuration/)

### Cilium Setup

- [Cilium Installation - Quick Start](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#k8s-install-quick)
- [Cilium Installation via Helm](https://docs.cilium.io/en/stable/installation/k8s-install-helm/)
- [Cilium kube-proxy free](https://docs.cilium.io/en/stable/network/kubernetes/kubeproxy-free/)

### Ansible References

- ["no-changed-when"](https://ansible.readthedocs.io/projects/lint/rules/no-changed-when/)
