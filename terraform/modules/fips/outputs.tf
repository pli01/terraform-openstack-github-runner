output "runner_fips" {
  # value = flatten([for value in openstack_networking_floatingip_v2.runner : value.address])
  value = openstack_networking_floatingip_v2.runner.address
}
