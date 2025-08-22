init:
	@export YC_TOKEN="$(yc iam create-token)"
	@terraform -chdir=./deploy init

plan:
	@terraform -chdir=./deploy get -update=true
	@terraform -chdir=./deploy fmt -recursive
	@terraform -chdir=./deploy validate
	@terraform -chdir=./deploy plan -var-file ../variables.tfvars

apply:
	@terraform -chdir=./deploy apply -var-file ../variables.tfvars

destroy:
	@terraform -chdir=./deploy destroy -var-file ../variables.tfvars
