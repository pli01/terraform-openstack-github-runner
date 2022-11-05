variable "ext_net_name" {
  type = string
}

variable "dns_nameservers" {
  type = list(string)
}

variable "default_cidr" {
  type = string
}
variable "default_next_hop" {
  type    = string
  default = ""
}
