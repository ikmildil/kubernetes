#!/bin/bash
#
# only on the master node.
#


echo -e "\n############################ --Section-4--Control Nodes ###########################\n"
IPADDR=$(curl ifconfig.me && echo "")
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

sudo kubeadm init --control-plane-endpoint=$IPADDR  --apiserver-cert-extra-sans=$IPADDR  --pod-network-cidr=$POD_CIDR --node-name $NODENAME --upload-certs

echo -e "\n############################ copy and paste the suggested above kubeadm command on worker nodes ###########################\n"

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config



kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml 
# to install the calico plugin (control node only). 
# Bean in Mind that Calico can take some time to all set up, you can still watch it by;
# kubectl get pods -n kube-system
