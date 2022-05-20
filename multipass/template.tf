data "template_file" "cloud_init_master" {
    template = "${file("${path.module}/script/cloud-init.yaml")}"
    vars = {
        k_version=var.kube_version
        ssh_public_key = "${file(pathexpand("~/.ssh/id_rsa.pub"))}"
        extra_cmd = ""
    }
}

data "template_file" "cloud_init_worker" {
    template = "${file("${path.module}/script/cloud-init.yaml")}"
    vars = {
        k_version=var.kube_version
        ssh_public_key = "${file(pathexpand("~/.ssh/id_rsa.pub"))}"
        extra_cmd = "- ${data.external.kubejoin.result.join} --cri-socket unix:///var/run/cri-dockerd.sock"
    }
}



