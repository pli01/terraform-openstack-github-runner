output "runner_public_ip" {
  value     = module.fips.*.runner_fips
  sensitive = true
}
output "runner_private_ip" {
  value     = module.runner.runner_private_ip
  sensitive = true
}
