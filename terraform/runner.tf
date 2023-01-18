#
# get the first network external name to associate one FIP to the first runner in the pool
#
locals {
  runner_fip_net = try(element(try(flatten([for key, value in var.router_config : value.extnet if value.allow_fip]), []), 0), "")
  enable_fip     = length(local.runner_fip_net) > 0 ? true : false
}

#
# create network resource based on router_config and subnet_routes_config variables
#
module "network" {
  source               = "./modules/network"
  dns_nameservers      = var.dns_nameservers
  default_cidr         = var.default_cidr
  router_config        = var.router_config
  subnet_routes_config = var.subnet_routes_config
}

#
# create one FIP on the first external network with allow_fip=true enabled
#
module "fips" {
  count                   = local.enable_fip ? 1 : 0
  source                  = "./modules/fips"
  fip_net_name            = local.runner_fip_net
  router_id               = module.network.router_id[0]
  router_internal_port_id = module.network.router_internal_port_id[0]
  depends_on = [
    module.network.router_id
  ]
}
#
# create pool of runner without ingress access by default
#   optional: if enable_fip is true, then only the first runner will be accessible with ssh port
#
module "runner" {
  source            = "./modules/runner"
  runner_name       = var.runner_name
  runner_count      = var.runner_count
  keypair_name      = var.keypair_name
  network_id        = module.network.network_id
  subnet_id         = module.network.subnet_id
  allow_fip         = local.enable_fip
  flavor            = var.runner_flavor
  image             = var.runner_image
  volume_type       = var.runner_volume_type
  volume_size       = var.runner_volume_size
  data_volume_size  = var.runner_data_volume_size
  gh_runner_version = var.gh_runner_version
  gh_runner_hash    = var.gh_runner_hash
  gh_runner_group   = var.gh_runner_group
  gh_url            = var.gh_url
  gh_token          = var.gh_token
  gh_label          = var.gh_label
  http_proxy        = var.http_proxy
  no_proxy          = var.no_proxy
  depends_on = [
    module.network.network_id,
    module.network.subnet_id
  ]
}

#
# create one lb, and associate the FIP of the first runner of the ppol
#
module "lb" {
  count              = local.enable_fip ? 1 : 0
  source             = "./modules/lb"
  runner_floating_ip = module.fips[0].runner_fips
  runner_address     = module.runner.runner_private_ip[0]
  subnet_id          = module.network.subnet_id
  depends_on = [
    module.fips.runner_fips,
    module.runner.runner_private_ip,
    module.network.subnet_id
  ]
}
