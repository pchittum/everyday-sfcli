#!/bin/bash 
# script to refresh sandbox with using record:update command from salesforce cli
# also a template for performing any Salesforce single record update
# this script could also serve as a template for invoking any sfdx command through a shell script

# possible fields for sandbox refresh: ApexClassId, AutoActivate, CopyArchivedActivities, CopyChatter, Description,
#   HistoryDays, LicenseType*, SandboxName, SourceId, TemplateId

# is salesforce cli installed?
if [[ ! -e $(which sfdx) ]]; then
  
  echo "The Salesforce CLI is not installed on this machine."
  echo "Please install from https://developer.salesforce.com/tools/sfdxcli."
  exit 1

fi

echo "Refresh sandbox script."

read -p "User or alias for parent org: " user

read -p "Sandbox name: " sbx 

read -p "License Type [DEVELOPER,DEVELOPER_PRO,PARTIAL,FULL]: " license

# construct sfdx command and arguments
# here's where a few tweaks could be done either to change the sobject or field(s) to update
# or different a different command and and its parameters could be used
command="sfdx force:data:record:update"
adminuser="-u $user"
whereflag="-w SandboxName=$sbx"
idflag="-i someidgoeshere" #not in use
sobject="-s SandboxInfo -t"
values="-v \"LicenseType='$license' AutoActivate=true\""

# reflect back command to user
echo "RUNNING COMMAND: $command $sobject $whereflag $adminuser $values"
  
# run command using eval
# eval currently required with complex value sets passed into the -v flag
# otherwise the single quote ASCII code is being passed to the API

eval "$command $sobject $whereflag $adminuser $values"

echo "To check refresh status use the record Id above with sfsandboxstatus.sh" 
echo "./sfsandboxstatus.sh [sbx record id]"
echo "Done."
exit 0