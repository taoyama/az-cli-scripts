#!/bin/bash

set +H

# deallocate all running vm
az vm deallocate --no-wait --ids `az vm list -d --query "[?!contains(powerState,'VM deallocated')].id" -o tsv`

# deallocate all vmss
for vmssid in `az vmss list --query '[].id' -o tsv`; do
	rg=`echo $vmssid | cut -d '/' -f 5`
	name=`echo $vmssid | cut -d '/' -f 9`
	az vmss deallocate -g $rg -n $name --no-wait
done
