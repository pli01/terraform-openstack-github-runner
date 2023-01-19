variable "dns_nameservers" {
  type = list(string)
}

variable "default_cidr" {
  type = string
}
variable "router_config" {
  type = list(object({
    name      = string
    ip        = string
    extnet    = string
    allow_fip = bool
  }))
}
variable "subnet_routes_config" {
  type = list(object({
    destination = string
    nexthop     = string
  }))
}
