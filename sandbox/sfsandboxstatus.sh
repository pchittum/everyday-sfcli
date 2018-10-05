#!/bin/bash
# retrieve information about the current sandbox refresh process for a single sandbox
# this means querying for the most recent SandboxProcess record for a given SandboxInfo Id
# could serve as template for performing any Salesforce single record update
# this script could also serve as a template for invoking any sfdx command through a shell script

# ensure we have the correct input
if [ "$#" != "2" ]; then

  echo "Missing required parameters"  
  echo "Usage of the sfsandboxstatus.sh script:"
  echo "$0 sandbox-info-id org-alias-or-user"
  echo "Exiting..."

  exit 1

fi

#get parameters into more intutively named variables
sbxinfoid=$1
user=$2

# query for the most recently started sandbox refresh
adminuser="-u $user"
command="sfdx force:data:soql:query"
query="-q \"SELECT SandboxName,Status,CopyProgress,AutoActivate,LicenseType,SandboxOrganization,StartDate FROM SandboxProcess WHERE SandboxInfoId = '$sbxinfoid' ORDER BY ActivatedDate DESC LIMIT 1\" -t"

echo "RUNNING COMMAND: ${command} ${query} ${adminuser}"
  
echo ""
echo "Fetching current status for sandbox id $sbxinfoid" 
eval "$command $query $adminuser"

echo "Done."
exit 0
