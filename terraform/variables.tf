variable "pm_api_url" {
  type        = string
  description = "URL of the Proxmox API endpoint"
}

variable "pm_user" {
  type        = string
  description = "Proxmox username (e.g. root@pam)"
}

variable "pm_password" {
  type        = string
  description = "Password for the Proxmox user"
  sensitive   = true
}

variable "pm_node" {
  type        = string
  description = "Target Proxmox node where VMs will be created"
  default     = "pve"
}

variable "template_name" {
  type        = string
  description = "Name of the cloud‑init template to clone"
}

variable "network_bridge" {
  type        = string
  description = "Name of the bridge or network to attach VMs to"
  default     = "vmbr0"
}

variable "gateway" {
  type        = string
  description = "Default gateway for the VMs"
}

variable "web_vmid" {
  type        = number
  description = "Static VMID for the web server VM"
  default     = 101
}

variable "web_ip" {
  type        = string
  description = "Static IP address for the web server VM"
}

variable "web_password" {
  type        = string
  description = "Temporary password for the cloud‑init user on the web VM"
  sensitive   = true
}

variable "ssh_public_key" {
  type        = string
  description = "Path to your public SSH key which will be injected into the VM"
  default     = "~/.ssh/id_rsa.pub"
}