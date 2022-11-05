variable "keypair_name" {
  type    = string
  default = ""
}
variable "ext_net_name" {
  type    = string
  default = "Ext-Net"
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

variable "runner_count" {
  type    = number
  default = 1
}

variable "dns_nameservers" {
  type    = list(string)
  default = ["213.186.33.99"]
}

variable "default_cidr" {
  type    = string
  default = "192.168.1.0/24"
}
variable "default_next_hop" {
  type    = string
  default = ""
}

variable "gh_runner_version" {
  type    = string
  default = "2.298.2"
}

variable "gh_runner_hash" {
  type    = string
  default = "0bfd792196ce0ec6f1c65d2a9ad00215b2926ef2c416b8d97615265194477117"
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

variable "allow_fip" {
  type    = bool
  default = false
}
