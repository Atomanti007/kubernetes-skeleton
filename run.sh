#!/bin/bash

sudo apt update -y \
&& sudo apt install docker.io -y \
&& docker --version \
&& sudo systemctl enable docker \
&& curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add \
&& sudo apt install curl -y \
&& sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" \
&& sudo apt install kubeadm -y \
&& kubeadm version \
&& sudo swapoff -a \
&& sudo hostnamectl set-hostname master-node \
&& sudo kubeadm init --pod-network-cidr=10.244.0.0/16 \
&& mkdir -p $HOME/.kube \
&& sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config \
&& sudo chown $(id -u):$(id -g) $HOME/.kube/config \
&& wget --no-cache -O ~/kubernetes/kube-flannel.yaml https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/kube-flannel.yaml \
&& sudo kubectl apply -f ~/kubernetes/kube-flannel.yaml \
&& wget --no-cache -O ~/kubernetes/dashboard.yaml https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/dashboard.yaml \
&& sudo kubectl apply -f ~/kubernetes/dashboard.yaml
