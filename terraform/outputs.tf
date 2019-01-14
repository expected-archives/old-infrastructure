data "template_file" "inventory" {
  template = "${file("templates/inventory.tpl")}"

  vars {
    connection_master = "${join("\n", formatlist("%s ansible_user=root private_ip=%s", scaleway_ip.master_ip.*.ip, scaleway_server.master_server.*.private_ip))}"
    connection_worker = "${join("\n", formatlist("%s ansible_user=root private_ip=%s", scaleway_ip.worker_ip.*.ip, scaleway_server.worker_server.*.private_ip))}"
    connection_tools = "${join("\n", formatlist("%s ansible_user=root private_ip=%s", scaleway_ip.tools_ip.*.ip, scaleway_server.tools_server.*.private_ip))}"
  }
}

resource "null_resource" "create_inventory" {
  triggers {
    template = "${data.template_file.inventory.rendered}"
  }

  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ../ansible/inventory"
  }
}

output "masters_privates_ips" {
  value = "${join(" ", scaleway_server.master_server.*.private_ip)}"
}

output "tools_ssh" {
  value = "ssh root@${scaleway_ip.tools_ip.ip}"
}

output "tools_private_ip" {
  value = "${scaleway_server.tools_server.private_ip}"
}
