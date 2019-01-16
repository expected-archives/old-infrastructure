output "addresses" {
  value = ["${scaleway_ip.master_ip.*.ip}"]
}

output "private_addresses" {
  value = ["${scaleway_server.master_server.*.private_ip}"]
}
