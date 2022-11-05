# cloudinit to bootstrap a runner host
data "cloudinit_config" "runner_config" {
  # order matter in multipart mime
  # cloud-init.cfg
  part {
    filename     = "cloud-init.cfg"
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/config-scripts/cloud-init.tpl", {
      ssh_authorized_keys = ""
    })
  }

  # generate config.cfg
  part {
    content_type = "text/plain"
    content = templatefile("${path.module}/config-scripts/generate-config.sh", {
      GH_RUNNER_VERSION = var.gh_runner_version
      GH_RUNNER_HASH    = var.gh_runner_hash
      GH_RUNNERGROUP    = var.gh_runner_group
      GH_URL            = var.gh_url
      GH_TOKEN          = var.gh_token
    })
  }

  # install-runner.sh
  part {
    content_type = "text/plain"
    content      = file("${path.module}/config-scripts/install-runner.sh")
  }
  # configure-runner.sh
  part {
    content_type = "text/plain"
    content      = file("${path.module}/config-scripts/configure-runner.sh")
  }
}

resource "openstack_compute_instance_v2" "runner" {
  count       = var.runner_count
  name        = "${terraform.workspace}-runner-${count.index + 1}"
  image_name  = var.image
  flavor_name = var.flavor
  key_pair    = var.keypair_name
  user_data   = data.cloudinit_config.runner_config.rendered

  network {
    port = element(openstack_networking_port_v2.runner.*.id, count.index)
  }

  metadata = {
    ssh_user      = "ubuntu"
    runner_groups = "runner"
  }
}

resource "openstack_blockstorage_volume_v2" "runner" {
  count       = var.runner_count > 0 && var.volume_size > 0 ? var.runner_count : 0
  name        = "${terraform.workspace}-runner-${count.index + 1}"
  size        = var.volume_size
  volume_type = var.volume_type
}

resource "openstack_compute_volume_attach_v2" "attached" {
  count = var.runner_count > 0 && var.volume_size > 0 ? var.runner_count : 0
  timeouts {
    create = "30m"
    delete = "30m"
  }

  instance_id = element(openstack_compute_instance_v2.runner.*.id, count.index)
  volume_id   = element(openstack_blockstorage_volume_v2.runner.*.id, count.index)
  depends_on = [
    openstack_compute_instance_v2.runner,
    openstack_blockstorage_volume_v2.runner
  ]
}
resource "openstack_networking_secgroup_v2" "runner" {
  name                 = "${terraform.workspace}-runner"
  description          = "runner server"
  delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.runner.id
}

resource "openstack_networking_secgroup_rule_v2" "runner" {
  count             = var.allow_fip ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "22"
  port_range_max    = "22"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.runner.id
}

resource "openstack_networking_port_v2" "runner" {
  count                 = var.runner_count
  name                  = "${terraform.workspace}-runner-${count.index + 1}"
  network_id            = var.network_id
  admin_state_up        = "true"
  port_security_enabled = true
  security_group_ids = [
    openstack_networking_secgroup_v2.runner.id
  ]
  no_security_groups = false
  fixed_ip {
    subnet_id = var.subnet_id
  }
}

