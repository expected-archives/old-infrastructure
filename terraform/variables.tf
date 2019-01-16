variable "domain" {
  type    = "string"
  default = "expected.sh"
}

variable "email" {
  type = "string"
}

variable "datacenter" {
  type    = "string"
  default = "paris"
}

variable "encryption_key" {
  type = "string"
}

variable "agent_token" {
  type = "string"
}

variable "scaleway_discovery_organization" {
  type = "string"
}

variable "scaleway_discovery_token" {
  type = "string"
}

variable "scaleway_discovery_region" {
  type = "string"
}

variable "drone_client_id" {
  type = "string"
}

variable "drone_client_secret" {
  type = "string"
}

variable "grafana_client_id" {
  type = "string"
}

variable "grafana_client_secret" {
  type = "string"
}
