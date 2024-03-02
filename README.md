# Creating Kubernetes Cluster Using Kubeadm:
My focus is not to have a long documentation about Kubernetes working and it’s architecture but more emphasis on how these commands and tools work in conjunction to make up our cluster. All these commands can be executed individually  step by step or run in a single script. When run individually we can find out  what really goes into creating a Kubernetes Cluster. 

These scripts have been tested on both Ubuntu 20.04 and 22.04 editions. I recommend 20.04 edition if possible because I have used this extensively in my own lab. The only difference regarding 22.04 that I came across was that while running scripts, the following  message  kept occurring which can be ignored. 

![frist](ubuntu2204y.png)

## Pre-requisites and Other Assumptions
- Knowledge of both Linux and Kubernetes. 
- 1 VM for Control Plane
- 2 VMs for Worker Nodes
- Installed OS: Ubuntu 20.04 or 22.04

You can either have these VMs in your own home lab or in the Cloud. Mine are in the  cloud. I have some usage of DigitalOcean free tier remaining, which I will be making use of. As long as you are using Ubuntu 20.04  or 22.04  make sure that the networking is properly configured, you should not have any problem to follow along.

## Agenda:

- Creating a Cluster of one Control Node and two Worker nodes with the following components;
	    - CRI-O container instead of ContainerD or Docker.
	    - Calico instead of Weave.

- installing nfs-server on Control node and nfs-clients on Workers.
	
- Installing Metrics-Server
	
- Installing Helm
	
- Create a Pod/Deployment, expose it and use it with Ingress.
## Notes:

Please  Do not run scripts without reading and making some adjustments to it first. Especially the ‘OS’ and ‘VER’ variables. The rest should be all good.

 Throughout the instructions set, we will be using root account. Most of the commands in here need root privileges, so it’s just easier to stay in root. Not a best practice for production env.



I have 3 sets of shell scripts, they all are very simple so that we can focus on commands & tools.
I am not going to explain these scripts in here . I will encourage you to rather read them yourself. Instead of  making  these script executable, you can use the sh command like so;
```
#sh     NAME_OF_SCRIPT.sh
```
Now that all this out of the way lets just have some fun with it. Let’s Do this.
```
1- run_on_all.sh:
```
	This will be run on all the nodes. Workers and Control/Master
```	
2-  run_on_master.sh
3- run_on_master-extra
```
	These two scripts should be run on Control/Master node only.

After finished executing all the scripts you should be able to execute the following command;

Pic-1:


