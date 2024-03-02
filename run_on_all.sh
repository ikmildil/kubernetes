#!/bin/bash
# 
# This script/commands will be run on ALL Nodes including Control/Master Node

echo -e "\n############################ --Section-1--All Nodes ###########################\n"

cat <<EOF | sudo tee /etc/modules-load.d/99-k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# Using sysctl params setting up network Bridging here 
# these changes are permanent

cat <<EOF | sudo tee /etc/sysctl.d/99-k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

# Also turning off swap and making it Persist
swapoff -a
# turning off swap in fstab file. we are commenting the the entry if it exists.
sed -i 's/\/swap/#\/swap/' /etc/fstab


echo -e "\n############################ --Section-2--All Nodes ###########################\n"

# the following os is not the pretty name of our workstation but of CRI-O owns labeling for ubuntus

OS="xUbuntu_20.04"
VER="1.28"

cat <<EOF | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /
EOF
cat <<EOF | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VER.list
deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VER/$OS/ /
EOF

curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VER/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -


apt-get update
apt-get install -y cri-o cri-o-runc cri-tools

echo -e "\n============================ Restarting and enabling crio ============================\n"

systemctl daemon-reload
systemctl enable --now crio

echo -e "\n############################ --Section-3--All Nodes ###########################\n"

echo -e "\n============================ some housekeeping before installing KUBEADM KUBECTL KUBELET ============================\n"


apt-get update
apt-get install -y apt-transport-https ca-certificates curl

curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/k8s.list

apt-get -y update

apt-cache madison kubeadm

apt-get install -y kubelet=1.28.2-00 kubectl=1.28.2-00 kubeadm=1.28.2-00

apt-mark hold kubelet kubeadm kubectl




