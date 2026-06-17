ANSIBLE_DIR := ansible
TF_DIR := terraform
INFO_COLOR := \033[36;1m
NO_COLOR := \033[0m

.PHONY: help tr_lint tr_plan tr_apply tr_output play build destroy
.DEFAULT_GOAL := help

help: ## show this help
	@grep -E "^[a-zA-Z_-]+:.*## .*$$" $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "$(INFO_COLOR)%-12s$(NO_COLOR) %s\n", $$1, $$2}'

tr_lint: ## format and validate terraform configs
	@cd $(TF_DIR) && terraform fmt && terraform validate

tr_plan: tr_lint ## plan the terraform changes
	@cd $(TF_DIR) && terraform plan

tr_apply: tr_plan ## apply the terraform changes
	@cd $(TF_DIR) && terraform apply

tr_output: ## outputs ip
	@cp $(TF_DIR)/dadavid-key.pem $(HOME)/dadavid-key.pem
	@chmod 600 $(HOME)/dadavid-key.pem
	@echo "[dd_web]" > $(ANSIBLE_DIR)/inventory.ini
	@echo "$$(cd $(TF_DIR) && terraform output -raw vm_ip_public) ansible_user=ec2-user ansible_ssh_private_key_file=$(HOME)/dadavid-key.pem" >> $(ANSIBLE_DIR)/inventory.ini

play: ## run the ansible playbook
	@ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i $(ANSIBLE_DIR)/inventory.ini $(ANSIBLE_DIR)/nginx.yml

build: tr_apply tr_output play ## full pipeline: terraform apply + inventory + playbook

destroy: ## destroy all terraform resources
	@cd $(TF_DIR) && terraform destroy
