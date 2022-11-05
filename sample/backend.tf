terraform {
  backend "s3" {
    bucket = "debug-runner-s3-tfstate"
    key    = "tfstate.tf"

    force_path_style            = true
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
