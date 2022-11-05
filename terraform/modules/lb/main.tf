resource "openstack_lb_loadbalancer_v2" "runner" {
  name           = "${terraform.workspace}-runner"
  vip_subnet_id  = var.subnet_id
  admin_state_up = true
}

resource "openstack_lb_listener_v2" "runner" {
  protocol        = "TCP"
  protocol_port   = 2222
  loadbalancer_id = openstack_lb_loadbalancer_v2.runner.id
}

resource "openstack_lb_pool_v2" "runner" {
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.runner.id
}

resource "openstack_lb_member_v2" "runner" {
  pool_id       = openstack_lb_pool_v2.runner.id
  address       = var.runner_address
  subnet_id     = var.subnet_id
  protocol_port = 22
}


resource "openstack_networking_floatingip_associate_v2" "runner" {
  floating_ip = var.runner_floating_ip
  port_id     = openstack_lb_loadbalancer_v2.runner.vip_port_id
  depends_on  = [openstack_lb_loadbalancer_v2.runner]
}

