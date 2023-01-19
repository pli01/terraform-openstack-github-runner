module "github-runner" {
  source                     = "../terraform"
  keypair_name               = var.keypair_name
  dns_nameservers            = var.dns_nameservers
  default_cidr               = var.default_cidr
  router_config              = var.router_config
  subnet_routes_config       = var.subnet_routes_config
  runner_url_deployer_script = var.runner_url_deployer_script
  runner_name                = var.runner_name
  runner_count               = var.runner_count
  runner_flavor              = var.runner_flavor
  runner_image               = var.runner_image
  runner_volume_type         = var.runner_volume_type
  runner_data_volume_size    = var.runner_data_volume_size
  runner_volume_size         = var.runner_volume_size
  gh_runner_version          = var.gh_runner_version
  gh_runner_hash             = var.gh_runner_hash
  gh_runner_group            = var.gh_runner_group
  gh_url                     = var.gh_url
  gh_token                   = var.gh_token
  gh_label                   = var.gh_label
  http_proxy                 = var.http_proxy
  no_proxy                   = var.no_proxy
}

