#!/bin/bash

# Run me on Heketi pod where heketi-cli is avialable in the K8s cluster

export hc='heketi-cli'

$hc node list | awk '{print $1}' | awk -F: '{print $2}' | while read node; do

device_id=$($hc node info $node | grep Size  | awk '{print $1}' | awk -F: '{print $2}')

echo ">>> Resyncing device $device_id on node $node ..."

$hc device resync $device_id

done
