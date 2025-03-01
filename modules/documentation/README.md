# Documentation Module

This Terraform module generates a documentation file based on the provided environment name, application size, and features.

## Variables

| Name      | Description                   | Type         | Default             | Required |
|-----------|-------------------------------|--------------|---------------------|----------|
| env_name  | The name of the environment   | string       | n/a                 | yes      |
| app_size  | Size of the application       | string       | n/a                 | yes      |
| features  | List of features              | list(string) | []                  | no       |
| paths     | Paths for the build           | object       | { build = "build" } | no       |

## Outputs

| Name                   | Description                                 |
|------------------------|---------------------------------------------|
| documentation_filename | The filename of the generated documentation |

## Usage

```hcl
module "documentation" {
  source  = "./modules/documentation"
  env_name = "production"
  app_size = "large"
  features = ["feature1", "feature2"]
  paths = {
    build = "dist"
  }
}
```

This will generate a documentation file at `dist/doc-production-large.md` with the specified content.
