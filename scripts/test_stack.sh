#!/bin/bash
# This script will test a heat stack creation
# Useful for when you change a resource and want to make sure you dont have typos
set -ex

export STACK_NAME=${STACK_NAME:-"test_stack"}

openstack stack create -e environments/user-rpc-on-rpc-13.1-full.yml -t templates/rpc-on-rpc-full.yml --timeout 240 --dry-run --wait $STACK_NAME
