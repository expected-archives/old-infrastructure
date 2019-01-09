resource "scaleway_server" "worker_server" {
  count               = "3"
  name                = "k8s-worker-${count.index}"
  type                = "START1-S"
  image               = "b286bb82-cf3b-4cb6-b454-4a7b3b47e8ad"
  tags                = ["kubernetes", "worker"]
  dynamic_ip_required = false
}
