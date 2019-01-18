data "template_file" "traefik_config" {
  count    = "${scaleway_ip.worker_ip.count}"
  template = "${file("${path.module}/templates/traefik.toml.tpl")}"

  vars {
    email   = "${var.email}"
    domain  = "${var.domain}"
  }
}

resource "null_resource" "traefik_deployment" {
  count = "${data.template_file.traefik_config.count}"

  triggers {
    config = "${element(data.template_file.traefik_config.*.rendered, count.index)}"
  }

  provisioner "file" {
    content     = "${element(data.template_file.traefik_config.*.rendered, count.index)}"
    destination = "/etc/traefik/traefik.toml"

    connection {
      host        = "${element(scaleway_ip.worker_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl enable traefik",
      "systemctl restart traefik"
    ]

    connection {
      host        = "${element(scaleway_ip.worker_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }
}
