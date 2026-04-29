terraform {
  required_version = ">= 1.3.0"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 2.9.0"
    }
  }
}

provider "proxmox" {
  # Proxmox API endpoint and authentication.  Replace with real values in your environment.
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = true
}

# Example: create a VM from a cloud‑init template
resource "proxmox_vm_qemu" "web" {
  name        = "web-01"
  target_node = var.pm_node
  vmid        = var.web_vmid
  clone       = var.template_name
  memory      = 2048
  cores       = 2
  sockets     = 1
  agents      = 1

  network {
    model = "virtio"
    bridge = var.network_bridge
    firewall = true
  }

  ipconfig0 = {
    ip = var.web_ip
    gateway = var.gateway
  }

  # Cloud-init user data to inject SSH keys
  ciuser     = "ubuntu"
  cipassword = var.web_password
  sshkeys    = file(var.ssh_public_key)

  # Wait until the guest agent is ready
  timeout = "5m"
}
