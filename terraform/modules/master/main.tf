data "scaleway_image" "master_image" {
  architecture  = "x86_64"
  name          = "${var.image}"
}

data "template_file" "cloud_init" {
  template = "${file("${path.module}/templates/cloud-init.tpl")}"

  vars {
    datacenter                      = "${var.datacenter}"
    bootstrap_expect                = 3
    scaleway_discovery_organization = "${var.scaleway_discovery_organization}"
    scaleway_discovery_token        = "${var.scaleway_discovery_token}"
    scaleway_discovery_region       = "${var.scaleway_discovery_region}"
    encryption_key                  = "${var.encryption_key}"
    agent_token                     = "${var.agent_token}"
  }
}

resource "scaleway_server" "master_server" {
  count               = 3
  name                = "master-${count.index}"
  type                = "START1-M"
  image               = "${data.scaleway_image.master_image.id}"
  tags                = ["consul-server", "nomad-server", "postgres", "kafka"]
  dynamic_ip_required = false
  cloudinit           = "${data.template_file.cloud_init.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "scaleway_ip" "master_ip" {
  count  = "${scaleway_server.master_server.count}"
  server = "${element(scaleway_server.master_server.*.id, count.index)}"

  lifecycle {
    create_before_destroy = true
  }
}
