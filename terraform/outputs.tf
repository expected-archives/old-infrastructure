//data "template_file" "ansible_inventory" {
//  template = "${file("${path.module}/inventory.tpl")}"
//  vars {
//    master = "${join("\n", scaleway_server.master_server.*.private_ip)}"
//    proxy = "${join("\n", scaleway_server.proxy_server.*.private_ip)}"
//    worker = "${join("\n", scaleway_server.worker_server.*.private_ip)}"
//  }
//}

//resource "local_file" "ansible_inventory_file" {
//  content = "${data.template_file.ansible_inventory.rendered}"
//  filename = "${path.module}/../ansible/inventory"
//}

output "masters" {
  value = "${join(",", scaleway_server.master_server.*.private_ip)}"
}

output "proxies" {
  value = "${join(",", scaleway_server.proxy_server.*.private_ip)}"
}

output "workers" {
  value = "${join(",", scaleway_server.worker_server.*.private_ip)}"
}
