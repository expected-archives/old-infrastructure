resource "cloudflare_record" "tools_drone_record" {
  domain = "${var.domain}"
  proxied = true
  name = "drone"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}

resource "cloudflare_record" "tools_grafana_record" {
  domain = "${var.domain}"
  proxied = true
  name = "grafana"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}

resource "cloudflare_record" "tools_consul_record" {
  domain = "${var.domain}"
  proxied = true
  name = "consul"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}

resource "cloudflare_record" "tools_nomad_record" {
  domain = "${var.domain}"
  proxied = true
  name = "nomad"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}

resource "cloudflare_record" "root_record" {
  count = "${scaleway_ip.worker_ip.count}"
  domain = "${var.domain}"
  proxied = true
  name = "@"
  type = "A"
  value = "${element(scaleway_ip.worker_ip.*.ip, count.index)}"
}

resource "cloudflare_record" "www_record" {
  count = "${scaleway_ip.worker_ip.count}"
  proxied = true
  domain = "${var.domain}"
  name = "www"
  type = "A"
  value = "${element(scaleway_ip.worker_ip.*.ip, count.index)}"
}
