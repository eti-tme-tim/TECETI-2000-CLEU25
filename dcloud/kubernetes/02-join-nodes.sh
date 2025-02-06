#!/usr/bin/env bash
# These commands must be run from the k8s-control-1 workstation
#
# Assumes that the ssh known_hosts file has been populated with the
# hostname based host keys via:
#    ssh-keyscan $i >> ${HOME}/.ssh/known_hosts

for i in $(awk '/k8s-worker/ {print $2;}' /etc/hosts); do
	cat ${HOME}/cluster.join.sh | ssh root@${i}
done

/usr/bin/kubectl get nodes
