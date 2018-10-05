#!/bin/bash
# retrieve most recent 20 sandboxes
# The best I can do as SOQL query WHERE clauses on the STATUS field don't seem to work.

# is salesforce cli installed?
if [[ ! -e $(which sfdx) ]]; then
  
  echo "The Salesforce CLI is not installed on this machine."
  echo "Please install from https://developer.salesforce.com/tools/sfdxcli."
  exit 1

fi

# ensure we have the correct input
if [ "$#" != "1" ]; then

  echo "Missing parameter."
  echo "Usage of the sfsandboxlist.sh script:"
  echo "$0 org-alias-or-user"
  echo ""

fi

adminuser="-u $1"

# query for the most recently started sandbox refresh
adminuser="-u $user"
command="sfdx force:data:soql:query"
query="-q \"SELECT SandboxName,Status,CopyProgress,AutoActivate,LicenseType,SandboxOrganization,StartDate FROM SandboxProcess ORDER BY ActivatedDate DESC LIMIT 20\" -t"

echo "RUNNING COMMAND: ${command} ${query} ${adminuser}"
  
echo ""
echo "Fetch most recent 20 Sandboxes."
eval "$command $query $adminuser"

echo "Done."
exit 0
