terraform {
  required_providers {
    dcloud = {
      version = "0.1.26"
      source  = "cisco-open/dcloud"
    }
  }
}

provider "dcloud" {
  tb_url = "https://tbv3-production.ciscodcloud.com/api"
}

# Define Topology to Create
resource "dcloud_topology" "k8s_cluster" {
  name        = "Kubernetes Cluster"
  description = "K8s Cluster in dCloud via TF"
  notes       = "Programmatic clients rule!"
  datacenter  = "RTP"
}

# Connectivity for vPOD
resource "dcloud_remote_access" "remote_access" {
  any_connect_enabled  = true
  endpoint_kit_enabled = false
  topology_uid         = dcloud_topology.k8s_cluster.id
}

# Create a primary network definition
resource "dcloud_network" "default_network" {
  name                 = "vPod Core Network"
  description          = "Default vPod Network"
  inventory_network_id = local.vpod_vlan_primary[0].id
  topology_uid         = dcloud_topology.k8s_cluster.id
}

# Fetch all available networks
data "dcloud_inventory_networks" "avail_networks" {
  topology_uid = dcloud_topology.k8s_cluster.id
}

# Fetch all available VMs
data "dcloud_inventory_vms" "avail_vms" {
  topology_uid = dcloud_topology.k8s_cluster.id
}

# Fetch all DNS Assets
data "dcloud_inventory_dns_assets" "avail_dns" {
  topology_uid = dcloud_topology.k8s_cluster.id
}

# Find my interesting resources
locals {
  ubuntu_server_22_04 = [
    for vm in data.dcloud_inventory_vms.avail_vms.inventory_vms : vm if vm.original_name == "ubuntu-22-04-server-80gb-preconfig-test"
  ][0]
  ubuntu_server_24_04 = [
    for vm in data.dcloud_inventory_vms.avail_vms.inventory_vms : vm if vm.original_name == "Ubuntu-server-24.04-2"
  ][0]
  vpod_vlan_primary = [
    for net in data.dcloud_inventory_networks.avail_networks.inventory_networks : net if net.id == "VLAN-PRIMARY"
  ]
}

# output "avail_networks" {
#   value = data.dcloud_inventory_networks.avail_networks
# }

# output "avail_vms" {
#   value = data.dcloud_inventory_vms.avail_vms
# }

# output "avail_dns" {
#   value = data.dcloud_inventory_vms.avail_dns
# }

# output "ubuntu_server_2204_vm" {
#   value = local.ubuntu_server_22_04
# }

# output "ubuntu_server_2404_vm" {
#   value = local.ubuntu_server_24_04
# }

# output "vlan_primary" {
#   value = local.vpod_vlan_primary
# }
