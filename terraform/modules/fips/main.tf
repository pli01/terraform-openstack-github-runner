resource "null_resource" "router_and_router_interface_are_created" {
  triggers = {
    dependency_id = var.router_id
  }
  depends_on = [
    var.router_internal_port_id
  ]
}

resource "openstack_networking_floatingip_v2" "runner" {
  pool       = var.fip_net_name
  depends_on = [null_resource.router_and_router_interface_are_created]
}
