# Create internet server
resource "digitalocean_droplet" "wireguard-vpn-internet-server" {
  image = "ubuntu-22-04-x64"
  name = "wireguard-vpn-internet-server"
  region = "nyc1"
  monitoring = true
  ipv6 = true
  droplet_agent = true
  backups = false
# Slug size
  size = "s-1vcpu-1gb" # CPU (1vCPU), RAM (1GB), DISK (25GB), TRANSFER 1TB, PRICE 6$
  # Import created ssh key to the droplet
  ssh_keys = [digitalocean_ssh_key.ansible-root-configuration-key.fingerprint]
}
# Create monitoring alerts
resource "digitalocean_monitor_alert" "wireguard_vpn_internet_cpu_alert" {
  alerts {
    email = ["stosic.n.stefan@gmail.com"]
  }
  description = "CPU usage higher that 70%"
  type        = "v1/insights/droplet/cpu"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [digitalocean_droplet.wireguard-vpn-internet-server.id]
}
resource "digitalocean_monitor_alert" "wireguard_vpn_internet_disk_alert" {
  alerts {
    email = ["stosic.n.stefan@gmail.com"]
  }
  description = "Disk usage higher that 70%"
  type        = "v1/insights/droplet/disk_utilization_percent"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [digitalocean_droplet.wireguard-vpn-internet-server.id]
}
resource "digitalocean_monitor_alert" "wireguard_vpn_internet_memory_alert" {
  alerts {
    email = ["stosic.n.stefan@gmail.com"]
  }
  description = "Memory usage higher that 70%"
  type        = "v1/insights/droplet/memory_utilization_percent"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [digitalocean_droplet.wireguard-vpn-internet-server.id]
}