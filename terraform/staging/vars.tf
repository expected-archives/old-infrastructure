variable "scaleway_organization" {
  type = "string"
}

variable "scaleway_token" {
  type = "string"
}

variable "scaleway_region" {
  type    = "string"
  default = "par1"
}

variable "cloudflare_email" {
  type = "string"
}

variable "cloudflare_token" {
  type = "string"
}

variable "domain" {
  type    = "string"
  default = "expected.sh"
}
