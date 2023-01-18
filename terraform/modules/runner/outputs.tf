output "runner_private_ip" {
  value = flatten(openstack_compute_instance_v2.runner.*.access_ip_v4)
}
