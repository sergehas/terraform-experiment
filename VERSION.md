# semver version in pure terraform

attempt to manage sem-versioning with terraform only

## principle

* store version # in a `local`
* define a module which
  * is "called" from `main.tf` (actually, `trigger.tf`), but ...
  * is not ran by default (`count=0`)
  * when enabled, compute the next version (bump major/minor/patch + meta) & generate a file (containing the `local` declaration) to store the version
* enable this module from the CLI with `tf plan -target="module.version" -var "do_version=true"`
