#!/bin/bash
# helm 

echo -e "\n############################ installing a nice littel tool called 'helm' ###########################\n"


wget https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz
tar xvf helm-v3.9.3-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin

helm version





kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl get pods -n kube-system

#---------------additional steps on terminal---------------------

#kubectl -n kube-system edit deployment metrics-server
# add the following to #spec -> template -> spec -> containers -> args
# --kubelet-insecure-tls
#
# now command 'kubectl top nodes' should work

echo -e "\n================================  additional steps on terminal and give it some time afterwards  ======================\n"
echo -e "\n================================ kubectl -n kube-system edit deployment metrics-server   ======================\n"
echo -e "\n================================  --kubelet-insecure-tls  ======================\n"
echo -e "\n================================  to the following to #spec -> template -> spec -> containers -> args  ======================\n"