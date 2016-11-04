#!/bin/bash
# This script will delete a heat stack for rpc-on-rpc

set -ex

export STACK_NAME=${STACK_NAME:-"test_stack"}

openstack stack delete --yes --wait $STACK_NAME
