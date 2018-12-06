#!/bin/sh

az vm get-instance-view --ids $(az vm list --query '[].id' -o tsv) | \
	jq '.[] | {ResourceGroup: .resourceGroup, VMName: .name, OS: .instanceView.osName, OSversion: .instanceView.osVersion, AgentVersion: .instanceView.vmAgent.vmAgentVersion}'
