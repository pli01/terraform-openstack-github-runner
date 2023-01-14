module "github-runner" {
  source                  = "../terraform"
  ext_net_name            = var.ext_net_name
  default_cidr            = var.default_cidr
  dns_nameservers         = var.dns_nameservers
  runner_name             = var.runner_name
  runner_count            = var.runner_count
  allow_fip               = var.allow_fip
  keypair_name            = var.keypair_name
  runner_flavor           = var.runner_flavor
  runner_image            = var.runner_image
  runner_volume_type      = var.runner_volume_type
  runner_data_volume_size = var.runner_data_volume_size
  runner_volume_size      = var.runner_volume_size
  network_name            = var.network_name
  subnet_name             = var.subnet_name
  gh_runner_version       = var.gh_runner_version
  gh_runner_hash          = var.gh_runner_hash
  gh_runner_group         = var.gh_runner_group
  gh_url                  = var.gh_url
  gh_token                = var.gh_token
  gh_label                = var.gh_label
  http_proxy              = var.http_proxy
  no_proxy                = var.no_proxy
}

