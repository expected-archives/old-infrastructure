resource "cloudflare_record" "tools_drone_record" {
  domain = "${var.domain}"
  name = "drone"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}

resource "cloudflare_record" "tools_grafana_record" {
  domain = "${var.domain}"
  name = "grafana"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}

resource "cloudflare_record" "tools_consul_record" {
  domain = "${var.domain}"
  name = "consul"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}

resource "cloudflare_record" "tools_vault_record" {
  domain = "${var.domain}"
  name = "vault"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}

resource "cloudflare_record" "tools_nomad_record" {
  domain = "${var.domain}"
  name = "nomad"
  type = "A"
  value = "${scaleway_ip.tools_ip.ip}"
}
