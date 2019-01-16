data "scaleway_image" "master_image" {
  architecture  = "x86_64"
  name          = "master"
}

resource "scaleway_server" "master_server" {
  count               = 3
  name                = "master-${count.index}"
  type                = "START1-M"
  image               = "${data.scaleway_image.master_image.id}"
  tags                = ["consul-server", "nomad-server", "postgres", "kafka"]
  dynamic_ip_required = false

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

data "template_file" "consul_config" {
  count  = "${scaleway_ip.master_ip.count}"
  template = "${file("${path.module}/templates/consul.json.tpl")}"

  vars {
    datacenter                      = "${var.datacenter}"
    bootstrap_expect                = 3
    scaleway_discovery_organization = "${var.scaleway_discovery_organization}"
    scaleway_discovery_token        = "${var.scaleway_discovery_token}"
    scaleway_discovery_region       = "${var.scaleway_discovery_region}"
    encryption_key                  = "${var.encryption_key}"
    private_ip                      = "${element(scaleway_server.master_server.*.private_ip, count.index)}"
  }
}

resource "null_resource" "consul_deployment" {
  count  = "${data.template_file.consul_config.count}"

  triggers {
    config = "${element(data.template_file.consul_config.*.rendered, count.index)}"
  }

  provisioner "file" {
    connection {
      host = "${element(scaleway_ip.master_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }

    content = "${element(data.template_file.consul_config.*.rendered, count.index)}"
    destination = "/etc/consul.d/consul.json"
  }

  provisioner "remote-exec" {
    connection {
      host = "${element(scaleway_ip.master_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }

    inline = [
      "systemctl enable consul",
      "systemctl restart consul"
    ]
  }
}

data "template_file" "nomad_config" {
  count  = "${scaleway_ip.master_ip.count}"
  template = "${file("${path.module}/templates/nomad.json.tpl")}"

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

resource "null_resource" "nomad_deployment" {
  count  = "${data.template_file.consul_config.count}"
  depends_on = ["null_resource.consul_deployment"]

  triggers {
    config = "${element(data.template_file.nomad_config.*.rendered, count.index)}"
  }

  provisioner "file" {
    connection {
      host = "${element(scaleway_ip.master_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }

    content = "${element(data.template_file.nomad_config.*.rendered, count.index)}"
    destination = "/etc/nomad.d/nomad.json"
  }

  provisioner "remote-exec" {
    connection {
      host = "${element(scaleway_ip.master_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }

    inline = [
      "systemctl enable nomad",
      "systemctl restart nomad"
    ]
  }
}
