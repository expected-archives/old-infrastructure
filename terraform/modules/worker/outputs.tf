output "addresses" {
  value = ["${scaleway_ip.worker_ip.*.ip}"]
}

output "private_addresses" {
  value = ["${scaleway_server.worker_server.*.private_ip}"]
}
