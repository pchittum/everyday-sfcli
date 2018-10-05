#!/bin/bash

# check is salesforce cli installed
if [[ ! -e $(which sfdx) ]]; then
  
  echo "The Salesforce CLI is not installed on this machine."
  echo "Please install from https://developer.salesforce.com/tools/sfdxcli."
  exit 1

fi

# check for org user or alias as first param 
# explicit setting of var to empty string is unnecessary, but done for clarity
if [[ $1 ]]; then 
  adminuser="-u $1"
else 
  echo "No user specified. Running on default scratch org for project."
  adminuser=""
fi

#capture stdout
dxoutput=$(date ; sfdx force:limits:api:display $adminuser | grep -v 'Daily' | grep -v 'Package2' | grep -v 'Concurrent' | grep -v 'SingleEmail'  | grep -v 'MassEmail' | grep -v 'Storage' | grep -v 'PermissionSets')

#scriptout=$($dxoutput > grep -v 'Hourly')

#this writes to stdout for this script
echo "${dxoutput}"
exit 0
