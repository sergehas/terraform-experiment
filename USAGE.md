<!-- BEGIN_TF_DOCS -->

# Usage

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
