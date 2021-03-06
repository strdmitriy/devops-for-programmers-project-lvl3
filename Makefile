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
	ansible-playbook -i ansible/inventory.ini -v --vault-password-file ansible/vault-password ansible/playbook.yml

encrypt-vault:
	ansible-vault encrypt $(FILE) --vault-password-file ansible/vault-password

decrypt-vault:
	ansible-vault decrypt $(FILE) --vault-password-file ansible/vault-password
