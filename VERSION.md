# semver version in pure terraform

attempt to manage sem-versioning with terraform only

## principle

* store version # in a `local`
* define a module which
  * is "called" from `main.tf` (actually, `trigger.tf`), but ...
  * is not ran by default (`count=0`)
  * computes the next version (bump major/minor/patch + optional prerelease)
* when enabled, the root module writes `version.tf` with the newly computed version

## CLI usage

```shell
terraform plan \
  -target="local_file.version_file" \
  -var "do_version=true" \
  -var "current_version=1.2.3" \
  -var "version_bump_part=minor" \
  -var "version_prerelease=SNAPSHOT"
```
