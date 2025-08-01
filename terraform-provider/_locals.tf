locals {
  naming_environment_type = "PreProduction"
  virtual_dir_prefix = upper(lower(local.naming_environment_type)) == "prod" ? "" : "testing the naman 4"
}
