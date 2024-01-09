# Add ssh key to the Digitalocean account that will be imported to the droplets and will be used for ansible configuration later
resource "digitalocean_ssh_key" "ansible-root-configuration-key" {
  name       = "ansible-root-configuration-key"
  public_key = file("/home/stefan/.ssh/ansible_root_configuration.pub")
}