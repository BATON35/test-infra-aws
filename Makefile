PLAN_FILE=plan.tfplan
JSON_FILE=plan.json

plan:
	terraform -chdir=terraform init
	terraform -chdir=terraform plan -var-file="terraform.tfvars.test" -out=$(PLAN_FILE)

json: plan
	terraform -chdir=terraform show -json $(PLAN_FILE) > terraform/$(JSON_FILE)

clean:
	rm -f terraform/$(PLAN_FILE) terraform/$(JSON_FILE)

# apply-dev:
# 	terraform apply -var-file="terraform.tfvars.dev"
#
# apply-prod:
# 	terraform apply -var-file="terraform.tfvars.prod"

apply-test:
	terraform -chdir=terraform init
	terraform -chdir=terraform apply -var-file="terraform.tfvars.test" -auto-approve

destroy-test:
	terraform -chdir=terraform destroy -var-file="terraform.tfvars.test"

# todo
# sprwdzić/naprawic te trzy komendy
# Dynamic SSM connection
connect:
	@echo "Connecting to Jenkins EC2 via SSM..."
	@cd terraform && terraform output -raw jenkins_instance_id > .instance_id
	@powershell -Command "$$ID = Get-Content terraform\\.instance_id; aws ssm start-session --target $$ID"
	@del terraform\.instance_id


# Show Jenkins URL
jenkins-url:
	@echo "Jenkins URL:"
	@cd terraform && terraform output -raw jenkins_public_ip | xargs -I {} echo "http://{}:8080"

# Show all outputs
outputs:
	cd terraform && terraform output

.PHONY: plan json clean
