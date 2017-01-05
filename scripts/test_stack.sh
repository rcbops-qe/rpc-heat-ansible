#!/bin/bash
# This script will test a heat stack creation
# Useful for when you change a resource and want to make sure you dont have typos
set -ex

export STACK_NAME=${STACK_NAME:-"test_stack"}
export STACK_TEMPLATE=${STACK_TEMPLATE:-"rpc-on-rpc-full.yml"}
export STACK_ENVIRONMENT=${STACK_ENVIRONMENT:-"rpc-on-rpc-master-full.yml"}

openstack stack create -e environments/$STACK_ENVIRONMENT -t templates/$STACK_TEMPLATE --timeout 240 --dry-run --wait $STACK_NAME
