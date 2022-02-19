### Hexlet tests and linter status:
[![Actions Status](https://github.com/strdmitriy/devops-for-programmers-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/strdmitriy/devops-for-programmers-project-lvl3/actions)

# Devops for programmers project lvl 2

This project about deliver app using terraform, ansible and docker images.
Project based docker image
- Docker
- Ansible
- DigitalOcean
- Datadog
- Terraform

## Required
- make init
- make apply
- make install - install ansible galaxy collection
- make deploy - run deployment image
- make encrypt-vault - encrypt vault variables
- make decrypt-vault - decrypt vault variables
- make touch-vault-password-file - create vault-password file

## Terraform
1. You need to save secret.auto.tfvars in ./terraform/ folder, which will contain your
    1. do_token: do-api-key
    2. datadog_api_key: datadog-api-key
    3. datadog_app_key: datadog-app-key

2. Change ssh in ./terraform/ssh.tf to the name of your ssh in DO

3. Use remote backend
    1. Create account https://app.terraform.io/app
    2. Follow the instructions on getting started page
    3. Create an organization and select the run terraform commands from local cli option
    4. Create a workspcae and follow instructions
    5. Change organization and workspaces inside the backend.tf file to what you have set them up in your account

## Ansible
Install ansible galaxy collections and role

to start project create file vault.yml in the folder /group_vars/webservers with vars for do_token and datadog,the names of the variables you can see in the vars.yml (/group_vars/webservers) and then you need to encrypt vault.yml file

## How to use
1. Run terraform command for setup your infrastructure
    1. make init
    2. make apply
2. Copy in the terraform output ip addresses to inventory.ini
3. Run ansible for deploy
    1. make deploy

