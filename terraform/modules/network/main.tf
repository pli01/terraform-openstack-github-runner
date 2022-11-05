data "openstack_networking_network_v2" "ext_net" {
  name = var.ext_net_name
}

resource "openstack_networking_router_v2" "runner" {
  name                = "${terraform.workspace}-runner"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.ext_net.id
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
  subnet_id        = openstack_networking_subnet_v2.runner.id
  destination_cidr = "0.0.0.0/0"
  next_hop         = var.default_next_hop == "" ? openstack_networking_subnet_v2.runner.gateway_ip : var.default_next_hop
}

resource "openstack_networking_router_interface_v2" "runner" {
  timeouts {
    create = "30m"
    delete = "30m"
  }

  router_id = openstack_networking_router_v2.runner.id
  subnet_id = openstack_networking_subnet_v2.runner.id
  depends_on = [
    openstack_networking_router_v2.runner,
    openstack_networking_network_v2.runner,
    openstack_networking_subnet_v2.runner,
    openstack_networking_subnet_route_v2.runner
  ]
}
