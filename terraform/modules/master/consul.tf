data "template_file" "consul_config" {
  count    = "${scaleway_ip.master_ip.count}"
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
  count = "${data.template_file.consul_config.count}"

  triggers {
    config = "${element(data.template_file.consul_config.*.rendered, count.index)}"
  }

  provisioner "file" {
    content     = "${element(data.template_file.consul_config.*.rendered, count.index)}"
    destination = "/etc/consul.d/consul.json"

    connection {
      host        = "${element(scaleway_ip.master_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl enable consul",
      "systemctl restart consul"
    ]

    connection {
      host        = "${element(scaleway_ip.master_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }
}
