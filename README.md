# Terraform demo & experiment

## Goal

- load workspace specific variables automatically (i.e. without taking the risk to load wrong `.tfvars` file with `-var-file` )
- provide a terraform only version number management implementing semver

## Prerequisites

- terraform workspace is mandatory
- terraform &gt;= 1.10

## Principle

- Dynamically load a file corresponding the current workspace
  - workspace must be explicitly selected (default workspace is not allowed)
  - workspace-specific `.tfvars` file must exist and contain all required variables
- workspace specific vars are `local`
  - no mixing with internal / module specific `variable`s. Variables defined this way (via `${env}.tfvars`) must **not** (nor can) be defined as `variable`
  - it is not possible to add validation rules to these variables
  - works also with `terraform output` (which doesn't support `-var-file` option)

## Benefits

- comparing 2 env is as simple as comparing 2 files!
- No risk to deploy with wrong configuration
- adding a new env is as simple as adding 1 file + 1 workspace

inspired by this [GitHub terraform discussion](https://github.com/hashicorp/terraform/issues/15966#issuecomment-2150853115)

## Starting up

- `shell`

  ```shell
  terraform init
  terraform workspace new dev
  terraform workspace new staging
  ```

- `docker`

  ```shell
  docker run --rm -v $(pwd):/workspace -w /workspace hashicorp/terraform init
  ```

## `.tfvars` per workspace demo

For this demo, the 'main' module is [`documentation`](modules/documentation/README.md) which basically
create a `md` file documented the infra. Of course, it does not create any infrastructure on any cloud provider

### Where the _magic_ (aka : automation) happens

```shell
terraform workspace select dev
#terraform apply -var-file="dev-env.tfvars" # the error prone way
terraform plan # "magic": no need to tell what .tfvars file to load!
terraform workspace select staging
terraform plan # "magic" again
```

## Running tests

Tests must run from a non-default workspace because the `default` workspace is intentionally rejected.

```shell
terraform workspace select dev
terraform test
```

If the workspace does not exist yet:

```shell
terraform workspace new dev
terraform workspace select dev
terraform test
```

## Version package generation

The [`version`](modules/version/README.md) flow renders an HCL file named `package.hcl` at repository root with content like:

```hcl
version = "1.1.0-SNAPSHOT"
```

The file is loaded only when `do_version=true` via `provider::terraform::decode_tfvars(file("package.hcl"))`. This keeps the version artifact commit-friendly for CI/CD while avoiding unconditional auto-loading and feedback loops tied to root `*.tf` files.

### Reset all

Remove all the local files created by terraform (listed in `.gitignore`)

```shell
git clean -xdf
```

## Documentation

To generate [documentation](USAGE.md), use

- `docker`

  ```shell
  docker run --rm --volume "$(pwd):/src" -u $(id -u) quay.io/terraform-docs/terraform-docs:latest -c /src/.config/.terraform.docs.yml /src
  ```

- `shell`

  ```shell
  terraform-docs .
  ```
