.PHONY: infra plan apply tf-apply clean mrproper destroy help
.DEFAULT_GOAL := help

AWS_PROFILE ?= default
NOW         := $(shell date +"%Y%m%d-%H%M%S")
RESOURCES   := terraform
TF_VARS     ?= $(RESOURCES)/terraform.tfvars
PLAN        := plan.out
export AWS_PROFILE

infra: plan apply ## Do whatever's needed to bring the infra up to date

plan: ## Plan, display and store that which would be needed to bring the infra up to date
	terraform plan -out $(PLAN) -var-file=$(TF_VARS) $(RESOURCES)/

apply: tf-apply clean ## Apply the current plan of operations to the infra, without replanning
tf-apply:
	terraform apply $(PLAN)

destroy: ## DANGER!!!! THIS DESTROYS THE WHOLE BOSH STACK!!!! BE SURE WHAT YOU ARE DOING!!!!!
	# bosh delete deployment --force concourse
	bosh-init delete bosh-director.yml
	terraform destroy -force -var-file=$(TF_VARS) $(RESOURCES)/

show: ## Print what the current plan of operations would do, without replanning
	terraform show $(PLAN)

clean: ## Archive the last plan
	mv $(PLAN) .$(PLAN).$(NOW)

help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
