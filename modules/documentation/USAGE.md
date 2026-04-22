<!-- BEGIN_TF_DOCS -->

# Usage

## Requirements

| Name  | Version |
| ----- | ------- |
| local | ~> 2.5  |

## Providers

| Name  | Version |
| ----- | ------- |
| local | ~> 2.5  |

## Module dependencies

| Name | Source | Version |
| ---- | ------ | ------- |

## Inputs

| Name     | Description                 | Type                         | Default                | Required |
| -------- | --------------------------- | ---------------------------- | ---------------------- | :------: |
| env_name | The name of the environment | `string`                     | n/a                    |   yes    |
| app_size | Size of the application     | `string`                     | n/a                    |   yes    |
| features | List of features            | `list(string)`               | `[]`                   |    no    |
| paths    | Paths for the build         | `object({ build = string })` | `{ "build": "build" }` |    no    |

## Outputs

| Name                   | Description                                  |
| ---------------------- | -------------------------------------------- |
| documentation_filename | Filename of the generated documentation file |

## Resources

| Name                                                                                                                | Type     |
| ------------------------------------------------------------------------------------------------------------------- | -------- |
| [local_file.documentation_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

<!-- END_TF_DOCS -->
