output "servers_ip" {
  value = "${scaleway_ip.master_ip.*.ip}"
}

output "servers_private_ip" {
  value = "${scaleway_server.master_server.*.private_ip}"
}
