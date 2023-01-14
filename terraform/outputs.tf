output "runner_private_ip" {
  value     = module.runner.runner_private_ip
  sensitive = true
}
