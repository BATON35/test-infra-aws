PLAN_FILE=plan.tfplan
JSON_FILE=plan.json

plan:
	terraform -chdir=terraform plan -out=$(PLAN_FILE)

json: plan
	terraform -chdir=terraform show -json $(PLAN_FILE) > terraform/$(JSON_FILE)

clean:
	rm -f terraform/$(PLAN_FILE) terraform/$(JSON_FILE)
apply-dev:
	terraform apply -var-file="terraform.tfvars.dev"

apply-prod:
	terraform apply -var-file="terraform.tfvars.prod"

apply-test:
	terraform apply -var-file="terraform.tfvars.test"


.PHONY: plan json clean
