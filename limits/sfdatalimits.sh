#!/bin/bash

if [[ ! -e $(which sfdx) ]]; then
  
  echo "The Salesforce CLI is not installed on this machine."
  echo "Please install from https://developer.salesforce.com/tools/sfdxcli."
  exit 1

fi

#capture stdout
dxoutput=$(date ; sfdx force:limits:api:display -u blixtar | grep -v 'Hourly' | grep -v 'Concurrent' | grep -v 'Daily' | grep -v 'Email' | grep -v 'Package')

#scriptout=$($dxoutput > grep -v 'Hourly')

#this writes to stdout for this script
echo "${dxoutput}"
exit 0
