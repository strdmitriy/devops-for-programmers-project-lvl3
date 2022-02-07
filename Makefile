init:
	terraform -chdir=terraform init

apply:
	terraform -chdir=terraform apply

plan:
	terraform -chdir=terraform plan

destroy:
	terraform -chdir=terraform destroy

install:
	ansible-galaxy collection install -r ansible/requirements.yml

deploy:
	ansible-playbook -i ansible/hosts -v --vault-password-file vault-password --ssh-extra-args "-F ssh_config" ansible/playbook.yml

encrypt-vault:
	ansible-vault encrypt $(FILE) --vault-password-file vault-password

decrypt-vault:
	ansible-vault decrypt $(FILE) --vault-password-file ansible/vault-password
