# Create dev server
resource "digitalocean_droplet" "wireguard-vpn-dev-server" {
  image = "ubuntu-22-04-x64"
  name = "wireguard-vpn-dev-server"
  region = "nyc1"
  monitoring = true
  ipv6 = true
  droplet_agent = true
  backups = false
# Slug size
  size = "s-1vcpu-1gb" # CPU (1vCPU), RAM (1GB), DISK (25GB), TRANSFER 1TB, PRICE 6$
  # Import created ssh key to the droplet
  ssh_keys = [digitalocean_ssh_key.ansible-configuration-key.fingerprint]
}
# Create monitoring alerts
resource "digitalocean_monitor_alert" "dev_cpu_alert" {
  alerts {
    email = ["stefan.stosic@forwardslashny.com"]
  }
  description = "CPU usage higher that 70%"
  type        = "v1/insights/droplet/cpu"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [digitalocean_droplet.wireguard-vpn-dev-server.id]
}
resource "digitalocean_monitor_alert" "dev_disk_alert" {
  alerts {
    email = ["stefan.stosic@forwardslashny.com"]
  }
  description = "Disk usage higher that 70%"
  type        = "v1/insights/droplet/disk_utilization_percent"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [digitalocean_droplet.wireguard-vpn-dev-server.id]
}
resource "digitalocean_monitor_alert" "dev_memory_alert" {
  alerts {
    email = ["stefan.stosic@forwardslashny.com"]
  }
  description = "Memory usage higher that 70%"
  type        = "v1/insights/droplet/memory_utilization_percent"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [digitalocean_droplet.wireguard-vpn-dev-server.id]
}