#!/bin/bash

# deallocate all running vm
az vm deallocate --ids `az vm list -d --query '[].{id:id, state:powerState}' | jq '. | map(select(.state == "VM running"))' | jq -r '.[].id'`

# deallocate all vmss
for vmssid in `az vmss list --query '[].id' -o tsv`; do
	rg=`echo $vmssid | cut -d '/' -f 5`
	name=`echo $vmssid | cut -d '/' -f 9`
	az vmss deallocate -g $rg -n $name
done
