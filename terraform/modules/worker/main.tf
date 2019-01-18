data "scaleway_image" "worker_image" {
  architecture  = "x86_64"
  name          = "worker"
}

resource "scaleway_server" "worker_server" {
  count               = 3
  name                = "worker-${count.index}"
  type                = "START1-S"
  image               = "${data.scaleway_image.worker_image.id}"
  tags                = ["consul-client", "nomad-client", "docker", "traefik"]
  dynamic_ip_required = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "scaleway_ip" "worker_ip" {
  count  = "${scaleway_server.worker_server.count}"
  server = "${element(scaleway_server.worker_server.*.id, count.index)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "worker_record" {
  count   = "${scaleway_ip.worker_ip.count}"
  domain  = "${var.domain}"
  name    = "proxy"
  type    = "A"
  proxied = true
  value   = "${element(scaleway_ip.worker_ip.*.ip, count.index)}"
}