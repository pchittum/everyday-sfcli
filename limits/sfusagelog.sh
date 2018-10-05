#!/bin/bash
# This was a prototype write-to-log script for reading org storage limits that could 
# be invoked from crontab. It should work, but the other example scripts simply capture
# and spit out stdout for use with MacOS's scheduler: launchd/launchctl. This should still
# work on a Linux system that was more friendly to crontab. 

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
dxoutput=$(date; sfdx force:limits:api:display $adminuser | grep -v 'Hourly' | grep -v 'Concurrent' | grep -v 'Daily' | grep -v 'Email' | grep -v 'Package')

#scriptout=$($dxoutput > grep -v 'Hourly')

#this writes to stdout for this script
echo "$dxoutput" >> log-output/usage.log
exit 0
