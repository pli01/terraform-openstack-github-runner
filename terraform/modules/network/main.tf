data "openstack_networking_network_v2" "ext_net" {
  count = length(var.router_config)

  name = var.router_config[count.index].extnet
}

resource "openstack_networking_router_v2" "runner" {
  count = length(var.router_config)

  name                = format("%s-%s-runner", terraform.workspace, var.router_config[count.index].name)
  external_network_id = data.openstack_networking_network_v2.ext_net[count.index].id
  admin_state_up      = true
}

resource "openstack_networking_network_v2" "runner" {
  name                  = "${terraform.workspace}-runner"
  admin_state_up        = true
  port_security_enabled = true
}

resource "openstack_networking_subnet_v2" "runner" {
  name            = "${terraform.workspace}-runner"
  network_id      = openstack_networking_network_v2.runner.id
  cidr            = var.default_cidr
  dns_nameservers = var.dns_nameservers
  ip_version      = 4
}

resource "openstack_networking_subnet_route_v2" "runner" {
  count = length(var.subnet_routes_config)

  subnet_id        = openstack_networking_subnet_v2.runner.id
  destination_cidr = var.subnet_routes_config[count.index].destination
  next_hop         = var.subnet_routes_config[count.index].nexthop == "" ? openstack_networking_subnet_v2.runner.gateway_ip : var.subnet_routes_config[count.index].nexthop
}

resource "openstack_networking_port_v2" "runner" {
  count              = length(var.router_config)
  name               = format("%s-%s-runner", terraform.workspace, var.router_config[count.index].name)
  admin_state_up     = "true"
  no_security_groups = false
  network_id         = openstack_networking_network_v2.runner.id
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.runner.id
    ip_address = var.router_config[count.index].ip
  }
}

resource "openstack_networking_router_interface_v2" "runner" {
  count = length(var.router_config)

  router_id = openstack_networking_router_v2.runner[count.index].id
  # subnet_id = openstack_networking_subnet_v2.runner.id
  port_id = openstack_networking_port_v2.runner[count.index].id
  depends_on = [
    openstack_networking_router_v2.runner,
    openstack_networking_network_v2.runner,
    openstack_networking_subnet_v2.runner,
    openstack_networking_subnet_route_v2.runner
  ]
  timeouts {
    create = "30m"
    delete = "30m"
  }
}
