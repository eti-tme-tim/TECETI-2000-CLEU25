# Define VM resources
resource "dcloud_vm" "jump_host" {
  inventory_vm_id   = local.ubuntu_server_24_04.id
  topology_uid      = dcloud_topology.k8s_cluster.id
  name              = "Linux Jump Host"
  description       = "A standard Ubuntu Desktop VM"
  cpu_qty           = 4
  memory_mb         = 8192
  nested_hypervisor = false
  os_family         = "LINUX"

  network_interfaces {
    network_uid = dcloud_network.default_network.uid
    name        = "Network adapter 0"
    mac_address = var.vpod_available_mac[0]
    type        = "VIRTUAL_VMXNET_3"
    ip_address  = "198.18.129.10"
    ssh_enabled = true
    rdp_enabled = false
  }

  remote_access {
    username           = "root"
    password           = "C1sco12345"
    vm_console_enabled = true
  }

  advanced_settings {
    all_disks_non_persistent = false
    bios_uuid                = var.vpod_available_uuid[0]
    name_in_hypervisor       = "k8s_cluster_jump_host"
    not_started              = false
  }
  guest_automation {
    command       = "/usr/bin/nmcli conn modify netplan-ens160 ipv4.method manual ipv4.addresses 198.18.129.11/18 ipv4.gateway 198.18.128.1 ipv4.dns 198.18.128.1 && /usr/bin/nmcli conn down netplan-ens160 && /usr/bin/nmcli conn up netplan-ens160"
    delay_seconds = 10
  }

}

resource "dcloud_vm" "control_node" {
  count = length(var.control_node_ip)

  inventory_vm_id   = local.ubuntu_server_24_04.id
  topology_uid      = dcloud_topology.k8s_cluster.id
  name              = "k8s-control-${count.index+1}"
  description       = "K8s Control Node #${count.index+1}"

  cpu_qty           = 4
  memory_mb         = 8192
  nested_hypervisor = false
  os_family         = "LINUX"

  network_interfaces {
    network_uid = dcloud_network.default_network.id
    name        = "Network adapter 0"
    mac_address = var.vpod_available_mac[count.index+1]
    type        = "VIRTUAL_VMXNET_3"
    ip_address  = var.control_node_ip[count.index]
    ssh_enabled = true
    rdp_enabled = false
  }

  remote_access {
    username           = "root"
    password           = "C1sco12345"
    vm_console_enabled = true
  }

  advanced_settings {
    all_disks_non_persistent = false
    bios_uuid                = var.vpod_available_uuid[count.index+1]
    name_in_hypervisor       = "k8s_cluster_control_node_${count.index}"
    not_started              = false
  }

  guest_automation {
    command       = "/usr/bin/nmcli conn modify netplan-ens160 ipv4.method manual ipv4.addresses ${var.control_node_ip[count.index]}/18 ipv4.gateway 198.18.128.1 ipv4.dns 198.18.128.1 && /usr/bin/nmcli conn down netplan-ens160 && /usr/bin/nmcli conn up netplan-ens160"
    delay_seconds = 10
  }
}

resource "dcloud_vm" "worker_node" {
  count = length(var.worker_node_ip)

  inventory_vm_id   = local.ubuntu_server_24_04.id
  topology_uid      = dcloud_topology.k8s_cluster.id
  name              = "k8s-worker-${count.index+1}"
  description       = "K8s Worker Node #${count.index+1}"

  cpu_qty           = 4
  memory_mb         = 8192
  nested_hypervisor = false
  os_family         = "LINUX"

  network_interfaces {
    network_uid = dcloud_network.default_network.uid
    name        = "Network adapter 0"
    mac_address = var.vpod_available_mac[count.index+length(var.control_node_ip)+1]
    type        = "VIRTUAL_VMXNET_3"
    ip_address  = var.worker_node_ip[count.index]
    ssh_enabled = true
    rdp_enabled = false
  }

  remote_access {
    username           = "root"
    password           = "C1sco12345"
    vm_console_enabled = true
  }

  advanced_settings {
    all_disks_non_persistent = false
    bios_uuid                = var.vpod_available_uuid[count.index+length(var.control_node_ip)+1]
    name_in_hypervisor       = "k8s_cluster_worker_node_${count.index}"
    not_started              = false
  }

  guest_automation {
    command       = "/usr/bin/nmcli conn modify netplan-ens160 ipv4.method manual ipv4.addresses ${var.worker_node_ip[count.index]}/18 ipv4.gateway 198.18.128.1 ipv4.dns 198.18.128.1 && /usr/bin/nmcli conn down netplan-ens160 && /usr/bin/nmcli conn up netplan-ens160"
    delay_seconds = 10
  }
}
