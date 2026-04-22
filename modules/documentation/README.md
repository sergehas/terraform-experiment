# Documentation Module

This Terraform module generates a documentation file based on the provided environment name, application size, and features.

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
