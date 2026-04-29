terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 2.9.0"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "web" {
  name        = "web"
  target_node = var.pm_node
  vmid        = var.web_vmid
  clone       = var.template_name
  memory      = 2048
  cores       = 2
  sockets     = 1
  agents      = 1

  network {
    model    = "virtio"
    bridge   = var.network_bridge
    firewall = true
  }

  ipconfig0 = {
    ip      = var.web_ip
    gateway = var.gateway
  }

  ciuser     = "ubuntu"
  cipassword = var.web_password
  sshkeys    = file(var.ssh_public_key)
}
