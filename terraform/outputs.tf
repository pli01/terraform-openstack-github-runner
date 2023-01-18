output "runner_private_ip" {
  value = module.runner.runner_private_ip
}
output "runner_fips" {
  value = one(module.fips[*].runner_fips)
}
output "runner_fip_net" {
  value = local.runner_fip_net
}
output "enable_fip" {
  value = local.enable_fip
}
