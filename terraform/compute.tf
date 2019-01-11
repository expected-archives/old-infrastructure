resource "scaleway_server" "master_server" {
  count               = 3
  name                = "master-${count.index}"
  type                = "START1-S"
  image               = "${var.master_image}"
  tags                = ["consul-server", "nomad-server", "agent-server", "postgres", "kafka"]
  dynamic_ip_required = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "scaleway_ip" "master_ip" {
  count  = 3
  server = "${element(scaleway_server.master_server.*.id, count.index)}"
}

resource "null_resource" "master_provisioning" {
  count = 3

  provisioner "remote-exec" {
    inline = [
      "echo ${}"
    ]

    connection {
      host        = "${element(scaleway_ip.master_ip.*.ip, count.index)}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }
}
