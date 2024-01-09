# WireGuard VPN Server project

## Infrastructure provisioning with Terraform

To be able to create resources we need to create API token on DigitalOcean account if we don't have one  
Next, we need to clone this repo and export the DigitalOcean API token as a localhost variable on a host from which we will run these scripts  
`export DO_PAT="<DigitalOcean API token>"`  
To create whole infrastructure we can use following commands  
`terraform init`  
`terraform plan -var "do_token=${DO_PAT}"`  
`terraform apply -auto-approve -var "do_token=${DO_PAT}"`  
To destroy infrastructure we can use following commands  
`terraform plan -destroy -out=terraform.tfplan -var "do_token=${DO_PAT}"`  
`terraform apply terraform.tfplan`  
To cleanup repo if there are some Terraform files left, we can use
`rm -rf terraform.tfplan terraform.tfstate terraform.tfstate.backup .terraform .terraform.lock.hcl`  

## Configuration management with Ansible

### Server Configuration

To initially configure a server (that is provisioned by Terraform) we need to run a playbook for server config (playbook_server_config.yml)  
`ansible-playbook ansible/playbook_server_config.yml --extra-vars "hosts=local_vm" -i ansible/inventory/wireguard_machines.ini -u root --private-key /home/stefan/.ssh/ansible_root_configuration --ask-vault-pass`  

- With `--extra-vars` variable `hosts` we define which machines we want to configure, more precisely what is the value of the hosts variable in the playbook  
- With argument `-i` we define in which inventory should ansible find a mentioned host, and therefore which variables to use  
- With argument `-u` we define as which host we are going to configure the server  
- With argument `--private-key` we define which private ssh key should we use to connect to the server as a defined user  
- Finally with the argument `--ask-vault-pass` ansible will prompt the System Administrator to decrypt the vault with the sensitive data  

## VPN usage

Now the WireGuard VPN server is fully configured. You need to create a WireGuard peer configuration file on a peer system and add a peer public key on a WireGuard VPN server to connect to it. Afterward, you can use your newly provisioned and configured WireGuard VPN server to browse the internet safely. Congrats! :ok_hand:
