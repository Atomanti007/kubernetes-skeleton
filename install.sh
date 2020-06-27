#!/bin/bash

#./run.sh
bash <(curl -s https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/run.sh)

#./heml/helm.sh
bash <(curl -s https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/helm/helm.sh)

#./openebs/install.sh
bash <(curl -s https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/openebs/install.sh)

#./elasticsearch/install.sh
bash <(curl -s https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/elasticsearch/install.sh)

#./kibana/install.sh
bash <(curl -s https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/kibana/install.sh)

#./logstash/install.sh
bash <(curl -s https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/logstash/install.sh)

