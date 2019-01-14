resource "scaleway_server" "master_server" {
  count               = 3
  name                = "master-${count.index}"
  type                = "START1-M"
  image               = "${var.master_image}"
  tags                = ["consul-server", "nomad-server", "postgres", "kafka"]
  dynamic_ip_required = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "scaleway_ip" "master_ip" {
  count  = "${scaleway_server.master_server.count}"
  server = "${element(scaleway_server.master_server.*.id, count.index)}"
}

output "ip" {
  value = "${join(" ", scaleway_ip.master_ip.*.ip)}"
}

# bbd821f7-f485-4be5-b391-864e798dde3a
