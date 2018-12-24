resource "scaleway_server" "master_server" {
  name                = "staging-k8s-master"
  type                = "START1-S"
  image               = "b286bb82-cf3b-4cb6-b454-4a7b3b47e8ad"
  tags                = ["staging", "kubernetes", "master"]
  dynamic_ip_required = false
}

resource "scaleway_server" "proxy_server" {
  name                = "staging-k8s-proxy"
  type                = "START1-S"
  image               = "b286bb82-cf3b-4cb6-b454-4a7b3b47e8ad"
  tags                = ["staging", "kubernetes", "proxy"]
  dynamic_ip_required = false
  security_group      = "${scaleway_security_group.proxy_security_group.id}"
}

resource "scaleway_server" "worker_server" {
  count               = 3
  name                = "staging-k8s-worker-${count.index}"
  type                = "START1-S"
  image               = "b286bb82-cf3b-4cb6-b454-4a7b3b47e8ad"
  tags                = ["staging", "kubernetes", "worker"]
  dynamic_ip_required = false
}
