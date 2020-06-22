#!/bin/bash


sudo apt update -y \
&& sudo apt install docker.io -y \
&& sudo systemctl enable docker \
&& sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl \
&& curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
&& echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list \
&& sudo apt-get update \
&& sudo apt-get install -y kubectl kubelet kubeadm \
&& sudo apt-get install bash-completion \
&& echo 'source <(kubectl completion bash)' >>~/.bashrc \
&& sudo swapoff -a \
&& sudo hostnamectl set-hostname master-node \
&& sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$(hostname -I | awk '{print $1}') \
&& mkdir -p $HOME/.kube \
&& sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config \
&& sudo chown $(id -u):$(id -g) $HOME/.kube/config \
&& kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')" \
&& kubectl apply -f https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/dashboard.yaml \
&& kubectl taint nodes --all node-role.kubernetes.io/master-
