module "network" {
  source           = "./modules/network"
  ext_net_name     = var.ext_net_name
  default_cidr     = var.default_cidr
  dns_nameservers  = var.dns_nameservers
  default_next_hop = var.default_next_hop
}

module "fips" {
  count                   = var.allow_fip ? 1 : 0
  source                  = "./modules/fips"
  ext_net_name            = var.ext_net_name
  router_id               = module.network.router_id
  router_internal_port_id = module.network.router_internal_port_id
  depends_on = [
    module.network.router_id
  ]
}

module "runner" {
  source            = "./modules/runner"
  runner_count      = var.runner_count
  allow_fip         = var.allow_fip
  keypair_name      = var.keypair_name
  flavor            = var.runner_flavor
  image             = var.runner_image
  volume_type       = var.runner_volume_type
  volume_size       = var.runner_volume_size
  network_id        = module.network.network_id
  subnet_id         = module.network.subnet_id
  gh_runner_version = var.gh_runner_version
  gh_runner_hash    = var.gh_runner_hash
  gh_runner_group   = var.gh_runner_group
  gh_url            = var.gh_url
  gh_token          = var.gh_token
  depends_on = [
    module.network.network_id,
    module.network.subnet_id
  ]
}

module "lb" {
  count              = var.allow_fip ? 1 : 0
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

