#!/bin/bash
set -ex

# Set ENV Variables
export TENANT=${TENANT:-"admin"}
export KEY_NAME=${KEY_NAME:-"ubuntu-key"}
export KEY_PATH=${KEY_PATH:-"~/.ssh/id_rsa.pub"}
export IMAGE_NAME=${IMAGE_NAME:-"ubuntu-trusty-heat-agent"}
export IMAGE_URL=${IMAGE_URL:-"http://ab031d5abac8641e820c-98e3b8a8801f7f6b990cf4f6480303c9.r33.cf1.rackcdn.com/ubuntu-trusty-heat-agent-2015_11.qcow2"}

# Set Local Variables
NEUTRON_TENANT="$(openstack user show $TENANT | grep id | grep -v domain | awk '{print $4}')"

# Setup Neutron Quotas for Tenant 
neutron quota-update --network -1 --subnet -1 --port -1 --router -1 --floatingip -1 --security-group -1 --security-group-rule -1 --tenant-id $TENANT

# Setup Keystone Quotas for Tenant
openstack quota set --ram -1 --secgroup-rules -1 --instances -1 --key-pairs -1 --fixed-ips -1 --secgroups -1 --injected-file-size -1 --floating-ips -1 --injected-files -1 --cores -1 --injected-path-size -1 --gigabytes -1 --volumes -1 --snapshots -1 $TENANT

# Add Image to Glance for Software Config
wget $IMAGE_URL -O "${IMAGE_NAME}.qcow2"
openstack image create --disk-format qcow2 --container-format bare --file "${IMAGE_NAME}.qcow2" --public $IMAGE_NAME

# Create RPC on RPC Flavors
openstack flavor create --ram 1024 --disk 20 --swap 1 --vcpus 2 --public rpc.small
openstack flavor create --ram 2048 --disk 40 --swap 2 --vcpus 4 --public rpc.medium
openstack flavor create --ram 4096 --disk 80 --swap 4 --vcpus 6 --public rpc.large

# Upload Public Key
# RIGHT NOW I DO THIS THROUGH HORIZON, NEED TO AUTOMATE A SHARED RPCQE KEY
# This needs to be your key if you want to use it for dev
openstack keypair create --public-key $KEY_PATH $KEY_NAME
