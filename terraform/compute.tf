resource "scaleway_server" "master_server" {
  count               = 3
  name                = "master-${count.index}"
  type                = "START1-M"
  image               = "b286bb82-cf3b-4cb6-b454-4a7b3b47e8ad"
  tags                = ["consul-server", "nomad-server", "postgres", "kafka"]
  dynamic_ip_required = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "scaleway_ip" "master_ip" {
  count  = "${scaleway_server.master_server.count}"
  server = "${element(scaleway_server.master_server.*.id, count.index)}"
}

resource "scaleway_server" "worker_server" {
  count               = 3
  name                = "worker-${count.index}"
  type                = "START1-S"
  image               = "b286bb82-cf3b-4cb6-b454-4a7b3b47e8ad"
  tags                = ["consul-client", "nomad-client"]
  dynamic_ip_required = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "scaleway_ip" "worker_ip" {
  count  = "${scaleway_server.worker_server.count}"
  server = "${element(scaleway_server.worker_server.*.id, count.index)}"
}

resource "scaleway_server" "tools_server" {
  name                = "tools"
  type                = "START1-M"
  image               = "b286bb82-cf3b-4cb6-b454-4a7b3b47e8ad"
  tags                = ["drone", "grafana", "prometheus"]
  security_group      = "${scaleway_security_group.tools_security_group.id}"
  dynamic_ip_required = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "scaleway_ip" "tools_ip" {
  server = "${scaleway_server.tools_server.id}"
}
