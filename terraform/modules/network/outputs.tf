output "router_id" {
  value = openstack_networking_router_v2.runner.id
}

output "network_id" {
  value = openstack_networking_network_v2.runner.id
}

output "router_internal_port_id" {
  value = openstack_networking_router_interface_v2.runner.id
}

output "subnet_id" {
  value = openstack_networking_subnet_v2.runner.id
}
