variable "keypair_name" {
  type    = string
  default = ""
}
variable "dns_nameservers" {
  description = "List of DNS"
  type        = list(string)
  default     = ["213.186.33.99"]
}
variable "default_cidr" {
  description = "Default private CIDR"
  type        = string
  default     = "192.168.1.0/24"
}

variable "router_config" {
  description = "list of map of routers configuration: router name, ip , external net, enable runner fip on this network"
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
  description = "list of map of routers configuration: destination route, nexthop to reach this destination"
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
  default = "2.300.2"
}

variable "gh_runner_hash" {
  type    = string
  default = "ed5bf2799c1ef7b2dd607df66e6b676dff8c44fb359c6fedc9ebf7db53339f0c"
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
  default = "https://raw.githubusercontent.com/pli01/terraform-openstack-github-runner/config-scripts/install-runner-scripts/deploy-runner.sh"
}


