output "runner_public_ip" {
  value     = module.github-runner.runner_public_ip
  sensitive = true
}
output "runner_private_ip" {
  value     = module.github-runner.runner_private_ip
  sensitive = true
}
