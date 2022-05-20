variable "disk" {
    default = "10G"
}

variable "mem" {
    default = "2G"
}

variable "cpu" {
    default = 2
}

variable "master" {
    default = "master-1"
}

variable "workers" {
  description = "workers"
#  default = [ "node-1" ]
  default = [ "node-1", "node-2", "node-3" ]
}

variable "kube_version" {
  default = "1.24.0-00"
}

