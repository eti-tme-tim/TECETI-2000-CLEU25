# Ubuntu-server-24.04-2
variable "ubuntu_server_24_04" {
  description = "Hardcoded VM ID for Ubuntu Server 24.04"
  type        = string
  default     = "14949802"
}

variable "control_node_ip" {
  description = "Define the control node IPs"
  type = list(string)
  default = [
    "198.18.129.20"
  ]
}

variable "worker_node_ip" {
  description = "Define the worker nodes IPs"
  type = list(string)
  default = [
    "198.18.129.21",
    "198.18.129.22",
    "198.18.129.23"
  ]
}

variable "vpod_available_mac" {
  description = "List of MAC addresses for VMS"
  type        = list(string)
  default = [
    "00:50:56:ba:dc:00",
    "00:50:56:ba:dc:01",
    "00:50:56:ba:dc:02",
    "00:50:56:ba:dc:03",
    "00:50:56:ba:dc:04",
    "00:50:56:ba:dc:05",
    "00:50:56:ba:dc:06",
    "00:50:56:ba:dc:07",
    "00:50:56:ba:dc:08",
    "00:50:56:ba:dc:09"
  ]
}

variable "vpod_available_uuid" {
  description = "List of UUIDs for VMs"
  type = list(string)
  default = [
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 80",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 81",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 82",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 83",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 84",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 85",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 86",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 87",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 88",
    "42 17 c8 59 2e 17 71 39-8b d9 07 d9 ff 05 91 89"
  ]
}
