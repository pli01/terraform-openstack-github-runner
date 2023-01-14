output "runner_private_ip" {
  value     = module.github-runner.runner_private_ip
  sensitive = true
}
