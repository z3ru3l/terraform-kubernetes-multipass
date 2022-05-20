# terraform-multipass-kubernetes
Builds a Local Kubernetes cluster the easiest way.

The cluster is build using [Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/), providing 1 master node and 3 worker nodes.
## Prerequisite:
* Terraform in MAC M1 - [Guide](https://kreuzwerker.de/en/post/use-m1-terraform-provider-helper-to-compile-terraform-providers-for-mac-m1)
* [Multipass](https://multipass.run/) - because latest MAC M1 is not supported by VirtualBox, this is the perfect replacement