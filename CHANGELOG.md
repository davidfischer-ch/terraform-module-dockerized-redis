# Changelog

## Release v1.2.1 (2026-03-21)

### Fix and enhancements

* Replace local-exec provisioners with a terraform_data resource for directory management

## Release v1.2.0 (2026-03-14)

### Minor compatibility breaks

* Remove the `CAP_` prefix from `cap_add` and `cap_drop` values — the module now adds it automatically when calling the Docker provider

### Fix and enhancements

* Add validation of `cap_add` and `cap_drop` against the exhaustive list of Linux capabilities
* Reorder variables to be consistent

## Release v1.1.1 (2026-03-13)

### Features

* Add Docker healthcheck using `redis-cli ping`

### Fix and enhancements

* Set `enabled` and `wait` defaults to `true`
* Refine variable descriptions, validators, and attribute ordering
* Remove redundant default values from examples and README

## Release v1.1.0 (2026-03-13)

### Breaking changes

* Replace `data_owner` by `app_uid`, `app_gid` with the same default values of `999`

### Fix and enhancements

* Add `# Process` section: `app_uid`, `app_gid`, `privileged`, `cap_add`, `cap_drop`
  variables wired into the container via `user`, `privileged`, and a dynamic `capabilities` block
* Rewrite README with usage example, data layout, variables/outputs tables, requirements
* Add `examples/default/` Terraform example

## Release v1.0.2 (2026-03-02)

### Features

* Add `data_owner` variable to parameterize data directory ownership

## Release v1.0.1 (2025-08-23)

### Fix and enhancements

* Set network mode to bridge to prevent infinite recreate loop

## Release v1.0.0 (2025-01-20)

Initial release
