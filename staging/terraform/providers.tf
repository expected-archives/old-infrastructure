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

provider "scaleway" {
  organization  = "${var.scaleway_organization}"
  token         = "${var.scaleway_token}"
  region        = "${var.scaleway_region}"
}
