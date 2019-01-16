output "master_addresses" {
  value = ["${module.master.addresses}"]
}

output "worker_addresses" {
  value = ["${module.worker.addresses}"]
}
