module "master" {
  source = "./modules/master"
}

module "worker" {
  source = "./modules/worker"
}

//module "consul" {
//  source                          = "./modules/consul"
//  datacenter                      = "${var.datacenter}"
//  encryption_key                  = "${var.encryption_key}"
//  agent_token                     = "${var.agent_token}"
//  scaleway_discovery_organization = "${var.scaleway_discovery_organization}"
//  scaleway_discovery_token        = "${var.scaleway_discovery_token}"
//  scaleway_discovery_region       = "${var.scaleway_discovery_region}"
//}
