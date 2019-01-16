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
