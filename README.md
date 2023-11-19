# WireGuard VPN Server project
# Infrastructure provisioning with Terraform
To be able to create resources we need to create API token on DigitalOcean account if we don't have one<br />
Next, we need to clone this repo and export the DigitalOcean API token as a localhost variable on a host from which we will run these scripts<br />
`export DO_PAT="<DigitalOcean API token>"`<br />
To create whole infrastructure we can use following commands<br />
`terraform init`<br />
`terraform plan -var "do_token=${DO_PAT}"`<br />
`terraform apply -auto-approve -var "do_token=${DO_PAT}"`<br />
To destroy infrastructure we can use following commands<br />
`terraform plan -destroy -out=terraform.tfplan -var "do_token=${DO_PAT}"`<br />
`terraform apply terraform.tfplan`<br />
To cleanup repo if there are some Terraform files left, we can use
`rm -rf terraform.tfplan terraform.tfstate terraform.tfstate.backup .terraform .terraform.lock.hcl`<br />
# Configuration management with Ansible
## Configuration
To initially configure a server (that is provisioned by Terraform) we need to run a playbook for server config (playbook_server_config.yml)<br />
`ansible-playbook ansible/playbook_server_config.yml --extra-vars "hosts=local_vm" -i ansible/inventory/wireguard_machines.ini -u root --private-key /home/stefan/.ssh/virtualbox --ask-vault-pass`<br />
- With `--extra-vars` variable `hosts` we define which machines we want to configure, more precisely what is the value of the hosts variable in the playbook<br />
- With argument `-i` we define in which inventory should ansible find a mentioned host, and therefore which variables to use<br />
- With argument `-u` we define as which host we are going to configure the server<br />
- With argument `--private-key` we define which private ssh key should we use to connect to the server as a defined user<br />
- Finally with the argument `--ask-vault-pass` ansible will prompt the System Administrator to decrypt the vault with the sensitive data<br />