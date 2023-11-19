terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Vars, do_token for accessing DigitalOcean account
variable "do_token" {}

# Here we say to terraform with which token to access DigitalOcean API
provider "digitalocean" {
  token = var.do_token
}