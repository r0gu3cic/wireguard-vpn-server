# Add ssh key to the Digitalocean account that will be imported to the droplets and will be used for ansible configuration later
resource "digitalocean_ssh_key" "ansible-configuration-key" {
  name       = "ansible-configuration-key"
  public_key = file("/home/stefan/.ssh/ansible_configuration_key.pub")
}