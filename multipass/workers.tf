resource "null_resource" "workers-node" {

    triggers = {
        id = "${data.external.workers[count.index].result.ip}"
    }

    connection {
        type = "ssh"
        host = "${data.external.workers[count.index].result.ip}"
        user = "root"
        private_key = "${file(pathexpand("~/.ssh/id_rsa"))}"
   }   
    provisioner "remote-exec" {
        inline = [
#            "cloud-init status --wait"
            "while [ ! -f /tmp/signal ]; do sleep 2; done"
        ]
    }
    provisioner "local-exec" {
        command = <<CMD
echo ${data.external.workers[count.index].result.ip} ${element(var.workers, count.index)} >> hosts_ip.txt
CMD 
    }    
    count = "${length(var.workers)}"
}

