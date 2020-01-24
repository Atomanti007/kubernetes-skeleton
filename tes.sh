#!/bin/bash

mkdir ~/kubernetes

wget https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/kube-flannel.yaml -O ~/kubernetes/kube-flannel.yaml
wget https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/dashboard.yaml -O ~/kubernetes/dashboard.yaml
