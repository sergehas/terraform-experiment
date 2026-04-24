# Review Checklist — terraform

## 1. Architecture

- [ ] File organization is clear (`terraform.tf`, `providers.tf`, `main.tf`, `variables.tf`, `outputs.tf`, `locals.tf` where needed)
- [ ] Resource/module naming is consistent and descriptive
- [ ] Module boundaries are appropriate (no unnecessary abstraction or deep nesting)
- [ ] Inputs/outputs are minimal, coherent, and documented
- [ ] Change scope and blast radius are explicitly identified

## 2. Testing

- [ ] `terraform fmt -check` passes
- [ ] `terraform validate` passes
- [ ] `terraform test` (or `.tftest.hcl` suite) passes where applicable
- [ ] `terraform plan -out=tfplan` reviewed and add/change/destroy counts are recorded
- [ ] Negative/edge cases are covered for changed module behavior when applicable

## 3. terraform language

- [ ] Variables include `description`, `type`, and validation where needed
- [ ] Outputs include `description` and are marked `sensitive` when needed
- [ ] Providers and modules are pinned to versions/immutable refs
- [ ] `for_each`/`count` usage is intentional and stable across applies
- [ ] `depends_on` is used only when necessary and lifecycle settings are justified

## 4. Security / Performance

- [ ] No hardcoded credentials, tokens, keys, or secrets
- [ ] Encryption at rest and in transit is enabled for sensitive services
- [ ] IAM policies follow least privilege and avoid broad wildcards
- [ ] Remote backend uses encryption and locking; state segregation is appropriate
- [ ] Drift detection process exists and rollback strategy is documented
