variable "runner_url_deployer_script" {
  default = "https://raw.githubusercontent.com/pli01/terraform-openstack-github-runner/config-scripts/terraform/modules/runner/config-scripts/deploy-runner.sh"
}

variable "runner_name" {
  default = ""
}

variable "runner_count" {
  type    = number
  default = 0
}

variable "keypair_name" {
  default = ""
}

variable "flavor" {}
variable "image" {}
variable "volume_type" {}
variable "volume_size" {
  type    = number
  default = 0
}
variable "data_volume_size" {
  type    = number
  default = 0
}

variable "network_id" {}
variable "subnet_id" {}
variable "allow_fip" {
  type = bool
}
variable "gh_runner_version" {}
variable "gh_runner_hash" {}
variable "gh_runner_group" {}
variable "gh_url" {}
variable "gh_token" {}
variable "gh_label" {}
variable "http_proxy" { default = "" }
variable "no_proxy" { default = "" }
