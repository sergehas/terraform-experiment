# Terraform demo & experiment

## Goal

load workspace specific variables automatically (i.e. without taking the risk to load wrong `.tfvars`  file with `-var-file` )

## Prerequisites

* terraform workspace is mandatory
* terraform &gt;= 1.8

## Principle

* Dynamically load a file corresponding the current workspace
* workspace specific vars are `local`
  * no mixing with internal / module specific `variable`s. Variables defined this way (via `${env}.tfvars`) must  **not* (nor can) be defined as `variable`
  * it is not possible to add validation rules to these variables
  * works also with `terraform output` (which doesn't support `-var-file` option)

## Benefits

* comparing 2 env is as simple as comparing 2 files!
* No risk to deploy with wrong configuration
* adding a new env is as simple as adding 1 file + 1 workspace

inspired by this [GitHub terraform discussion](https://github.com/hashicorp/terraform/issues/15966#issuecomment-2150853115)

## Starting up

```shell
terraform init
terraform workspace new dev
terraform workspace new staging
```

## Demo

```shell
terraform workspace select dev
#terraform apply -var-file="dev-env.tfvars" # the error prone way
terraform plan # "magic": no need to tell what .tfvars file to load!
terraform workspace select staging
terraform plan # "magic" again
```
