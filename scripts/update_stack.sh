#!/bin/bash
# This script will update a heat stack for rpc-on-rpc

set -ex

export STACK_NAME=${STACK_NAME:-"test_stack"}
export STACK_TEMPLATE=${STACK_TEMPLATE:-"rpc-on-rpc-full.yml"}
export STACK_ENVIRONMENT=${STACK_ENVIRONMENT:-"rpc-on-rpc-master-full.yml"}

openstack stack update -e environments/$STACK_ENVIRONMENT -t templates/$STACK_TEMPLATE --timeout 240 --wait $STACK_NAME
