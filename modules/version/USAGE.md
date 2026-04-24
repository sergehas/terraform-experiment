<!-- BEGIN_TF_DOCS -->

# semver module

manage sem-versioning with terraform only

## principle

- store version # in a `local`
- define a module which
  - is "called" from `main.tf` (actually, `trigger.tf`), but ...
  - is not ran by default (`count=0`)
  - computes the next version (bump major/minor/patch + optional prerelease)
- when enabled, the root module writes `package.hcl` at repository root

## refactor notes

- the version module now owns the rendering of the generated Terraform content
- the generated file name defaults to `package.hcl`
- `package.hcl` is decoded only when `do_version=true`
- this avoids unconditional auto-loading/re-evaluation that happens with root `*.tf` files

## CLI usage

```shell
terraform plan \
  -target="local_file.package_file" \
  -var "do_version=true" \
  -var "current_version=0.0.0" \
  -var "version_bump_part=minor" \
  -var "version_prerelease=SNAPSHOT"
```

## Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 1.10.0 |

## Providers

No providers.

## Module dependencies

| Name | Source | Version |
| ---- | ------ | ------- |

## Inputs

| Name           | Description                                                  | Type     | Default | Required |
| -------------- | ------------------------------------------------------------ | -------- | ------- | :------: |
| actual_version | Version string written into the generated version file       | `string` | n/a     |   yes    |
| bump_part      | Part of semantic version to increment                        | `string` | n/a     |   yes    |
| prerelease     | Optional prerelease suffix to append to the computed version | `string` | `""`    |    no    |

## Outputs

| Name                 | Description                                                   |
| -------------------- | ------------------------------------------------------------- |
| new_version          | The newly computed semantic version                           |
| package_file_content | Terraform locals declaration that stores the computed version |
| package_file_name    | Default filename for the generated Terraform package file     |

## Resources

No resources.

<!-- END_TF_DOCS -->
