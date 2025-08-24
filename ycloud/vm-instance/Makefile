init:
	# @export YC_TOKEN="$(yc iam create-token)"
	@terraform init
	@ssh-keygen -t ed25519 -f ycvm

plan:
	@terraform get -update=true
	@terraform fmt -recursive
	@terraform validate
	@terraform plan -var-file variables.tfvars

apply:
	@terraform apply -var-file variables.tfvars

destroy:
	@terraform destroy -var-file variables.tfvars
