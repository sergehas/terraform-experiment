<!-- BEGIN_TF_DOCS -->

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

## Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 1.10.0 |
| local     | ~> 2.5    |

## Providers

| Name  | Version |
| ----- | ------- |
| local | 2.8.0   |

## Module dependencies

| Name                                                | Source                  | Version |
| --------------------------------------------------- | ----------------------- | ------- |
| [`documentation`](./modules/documentation/USAGE.md) | ./modules/documentation |         |
| [`version`](./modules/version/USAGE.md)             | ./modules/version       |         |

## Inputs

| Name                 | Description                                                            | Type          | Default                              | Required |
| -------------------- | ---------------------------------------------------------------------- | ------------- | ------------------------------------ | :------: |
| do_version           | Enable generation of the package version file                          | `bool`        | `false`                              |    no    |
| current_version      | Current semantic version in format MAJOR.MINOR.PATCH                   | `string`      | `"1.0.0"`                            |    no    |
| version_bump_part    | Part of the semantic version to bump                                   | `string`      | `"patch"`                            |    no    |
| version_prerelease   | Optional prerelease suffix added to generated version                  | `string`      | `"SNAPSHOT"`                         |    no    |
| version_package_file | Path to package HCL file used as version input when do_version is true | `string`      | `"package.hcl"`                      |    no    |
| app_name             | The name of the application                                            | `string`      | `"demo-app"`                         |    no    |
| paths                | A map of paths                                                         | `map(string)` | `{ "build": "build", "src": "src" }` |    no    |

## Outputs

| Name               | Description                                     |
| ------------------ | ----------------------------------------------- |
| documentation_file | Generated documentation filename                |
| env_name           | Resolved environment name from workspace tfvars |
| tags               | Default tags applied to resources               |
| ws_variables       | All decoded workspace variables                 |

## Resources

| Name                                                                                                          | Type     |
| ------------------------------------------------------------------------------------------------------------- | -------- |
| [local_file.package_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

<!-- END_TF_DOCS -->
