keypair_name       = "ansible"
runner_flavor      = "b2-7"
runner_count       = 1
runner_volume_size = 10
gh_token           = ""
gh_url             = ""

router_config = [
  { name = "rt_runner", ip = "192.168.1.1", extnet = "Ext-Net", allow_fip = false }
]
subnet_routes_config = [
  { destination = "0.0.0.0/0", nexthop = "192.168.1.1" }
]
