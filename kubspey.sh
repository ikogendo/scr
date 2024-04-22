#/bin/bash
SRC_IP=$1;SRC_IP="${SRC_IP:-source.ip}"
if ! command -v pip3 install &> /dev/null; then apt install python3 python3-pip -y ; fi
git clone https://github.com/kubernetes-sigs/kubespray;cd kubespray/; pip3 install -r requirements.txt; cp -pr inventory/sample inventory/local
declare -a IPS=($(cat $SRC_IP))
CONFIG_FILE=inventory/local/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
find ./ -name  k8s-cluster.yaml -exec sed -i -e"/kubeconfig_localhost:/d" {} ; echo "kubeconfig_localhost: true" >> {} \;
