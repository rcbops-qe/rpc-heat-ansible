#!/bin/bash
# This script will create a heat stack for rpc-on-rpc

set -ex

export STACK_NAME=${STACK_NAME:-"test_stack"}

openstack stack create -e environments/user-rpc-on-rpc-13.1-full.yml -t templates/rpc-on-rpc-full.yml --timeout 240 --wait $STACK_NAME
