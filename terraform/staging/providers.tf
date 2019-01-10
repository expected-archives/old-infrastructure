provider "scaleway" {
  organization  = "${var.scaleway_organization}"
  token         = "${var.scaleway_token}"
  region        = "${var.scaleway_region}"
}

provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}
