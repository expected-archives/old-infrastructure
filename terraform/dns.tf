resource "cloudflare_record" "k8s_dns" {
  domain  = "expected.sh"
  name    = "k8s"
  type    = "A"
  value   = "${scaleway_ip.master_ip.ip}"
  proxied = true
}

resource "cloudflare_record" "root_dns" {
  domain  = "expected.sh"
  name    = "@"
  type    = "A"
  value   = "${scaleway_ip.proxy_ip.ip}"
  proxied = true
}

resource "cloudflare_record" "www_dns" {
  domain  = "expected.sh"
  name    = "www"
  type    = "A"
  value   = "${scaleway_ip.proxy_ip.ip}"
  proxied = true
}

resource "cloudflare_record" "grafana_dns" {
  domain  = "expected.sh"
  name    = "grafana"
  type    = "A"
  value   = "${scaleway_ip.proxy_ip.ip}"
  proxied = true
}
