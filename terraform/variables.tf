variable "keypair_name" {
  type    = string
  default = ""
}

variable "dns_nameservers" {
  type    = list(string)
  default = ["213.186.33.99"]
}

variable "default_cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "router_config" {
  type = list(object({
    name      = string
    ip        = string
    extnet    = string
    allow_fip = bool
  }))
  default = [
    { name = "rt_apps", ip = "192.168.1.1", extnet = "Ext-Net", allow_fip = false }
  ]
}

variable "subnet_routes_config" {
  type = list(object({
    destination = string
    nexthop     = string
  }))
  default = [
    { destination = "0.0.0.0/0", nexthop = "192.168.1.1" }
  ]
}

variable "runner_flavor" {
  type    = string
  default = "s1-2"
}

variable "runner_image" {
  type    = string
  default = "Ubuntu 20.04"
}

variable "runner_volume_type" {
  type    = string
  default = "classic"
}

variable "runner_volume_size" {
  type    = number
  default = 0
}
variable "runner_data_volume_size" {
  type    = number
  default = 0
}

variable "runner_name" {
  default = ""
}

variable "runner_count" {
  type    = number
  default = 1
}

variable "gh_runner_version" {
  type    = string
  default = "2.299.1"
}

variable "gh_runner_hash" {
  type    = string
  default = "147c14700c6cb997421b9a239c012197f11ea9854cd901ee88ead6fe73a72c74"
}

variable "gh_runner_group" {
  type    = string
  default = "Default"
}

variable "gh_url" {
  type = string
}
variable "gh_token" {
  type = string
}

variable "gh_label" {
  type    = string
  default = ""
}
variable "http_proxy" {
  type    = string
  default = ""
}
variable "no_proxy" {
  type    = string
  default = ""
}

variable "runner_url_deployer_script" {
  default = "https://raw.githubusercontent.com/pli01/terraform-openstack-github-runner/config-scripts/terraform/modules/runner/config-scripts/deploy-runner.sh"
}
