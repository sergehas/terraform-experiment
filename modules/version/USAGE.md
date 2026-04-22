<!-- BEGIN_TF_DOCS -->

# Usage

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
