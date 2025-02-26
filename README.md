# Terraform demo & experiment

## goal

load workspace specific variables automatically (i.e. without taking the risk to load wrong `.tfvars`  file with `-var-file` )

## Prerequisites

* terraform workspace is mandatory
* terraform &gt;= 1.8

## principle

* Dynamically load a file corresponding the current workspace name
* workspace specific vars are local
  * no mixing with internal / module specific variables. Variables defined this way (in `${env}.tfvars`) must (nor can) **not* be defined as `variable`
  * it is not possible to add validation rules to these variable
  * works also with `terraform output` (whi does't support `-var-file` option )
* comparing 2 env is as simple as comparing 2 files
inspired by this [GitHub terraform discussion](https://github.com/hashicorp/terraform/issues/15966#issuecomment-2150853115)

## starting up

```shell
terraform init
terraform workspace new dev
terraform workspace new staging
terraform workspace select dev
```

## use

```shell
#terraform apply -var-file="dev-env.tfvars"
terraform plan #magic : no need to tel what .tfvars file to load
```
