resource "null_resource" "master-node" {

    triggers = {
        id = "${data.external.master.result.ip}"
    }

    connection {
        type = "ssh"
        host = "${data.external.master.result.ip}"
        user = "root"
        private_key = "${file(pathexpand("~/.ssh/id_rsa"))}"
    }
 
    provisioner "remote-exec" {
        script = "${path.module}/script/kube-init.sh"
    }

    provisioner "local-exec" {
        command = <<CMD
mkdir ${pathexpand("~/.kube")}
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -i ${pathexpand("~/.ssh/id_rsa")} root@${data.external.master.result.ip}:/etc/kubernetes/admin.conf ${pathexpand("~/.kube/config-local")}
cat ${pathexpand("~/.kube/config-local")} >> ${pathexpand("~/.kube/config")}
echo ${data.external.master.result.ip} ${var.master} > hosts_ip.txt
CMD 
    }
}

