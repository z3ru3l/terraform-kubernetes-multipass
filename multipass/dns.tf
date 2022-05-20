resource "null_resource" "master-dns" {
    depends_on = [null_resource.workers-node]

    triggers = {
        id = "${data.external.master.result.ip}"
    }

    connection {
        type = "ssh"
        host = "${data.external.master.result.ip}"
        user = "root"
        private_key = "${file(pathexpand("~/.ssh/id_rsa"))}"
    }
 
#     provisioner "local-exec" {
#         command = <<CMD
# scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -i ${pathexpand("~/.ssh/id_rsa")} hosts_ip.txt root@${data.external.master.result.ip}:/tmp/hosts_ip.txt
# CMD 
#     }
    provisioner "file" {
        source = "hosts_ip.txt"
        destination = "/tmp/hosts_ip.txt"
    }

    provisioner "remote-exec" {
        inline = [
          "cat /tmp/hosts_ip.txt >> /etc/hosts",
        ]
    }
}

resource "null_resource" "workers-dns" {
    depends_on = [null_resource.workers-node]

    triggers = {
        id = "${data.external.workers[count.index].result.ip}"
    }

    connection {
        type = "ssh"
        host = "${data.external.workers[count.index].result.ip}"
        user = "root"
        private_key = "${file(pathexpand("~/.ssh/id_rsa"))}"
   }   

#     provisioner "local-exec" {
#         command = <<CMD
# scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -i ${pathexpand("~/.ssh/id_rsa")} hosts_ip.txt root@${data.external.workers[count.index].result.ip}:/tmp/hosts_ip.txt
# CMD 
#     }
    provisioner "file" {
        source = "hosts_ip.txt"
        destination = "/tmp/hosts_ip.txt"
    }
    provisioner "remote-exec" {
        inline = [
          "cat /tmp/hosts_ip.txt >> /etc/hosts",
        ]
    }
    count = "${length(var.workers)}"
}