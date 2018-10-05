#!/bin/bash
# retrieve user data fields, or subset of fields
# could serve as template for performing any Salesforce single record update
# this script could also serve as a template for invoking any sfdx command through a shell script

if [ "$#" != "2" ]; then
# check for 2 inputs and handle
# 1 input only assumes we have a username and use default DX project user 
# no inputs or more than 2 and we just fail out

  echo "Usage of the sfuserdeactivate.sh script:"
  echo "$0 username@to.fetch [org-alias-or-user]"
  echo ""

  if [ "$#" = "1" ]; then
    
    #ask for verification then proceed with default project user
    echo ""
    echo "Fetching user from the org for the default project user. Enter 'y' to proceed."

    read answer

    if [ $answer != "y" ]; then
    # if they respond with anything other than 'y' we exit
      echo "Exiting..."

      exit 1

    fi
  
  else 
    
    echo "Exiting..."

    exit 1

  fi

fi

# we're good to go let's go deactivate them.

# the org user alias is our one optional input. 
# handle if we don't have that input
if [ -n "$2" ]; then

  adminuser="-u $2"

else 

  adminuser=""

fi

# construct sfdx command and arguments
# here's where a few tweaks could be done either to change the sobject or field(s) to update
# or different a different command and and its parameters could be used
command="sfdx force:data:record:get"
whereflag="-w Username=$1"
sobject="-s User"
#values="-v IsActive=false"

echo "RUNNING COMMAND: ${command} ${sobject} ${whereflag} ${adminuser}"
  
#run the command and pass through stdout. 
$command $sobject $whereflag $adminuser

echo "Done."


# sfdx force:data:record:update -w [where record matches field value] -s User -u [my alias] -v IsActive=falseexit 0
