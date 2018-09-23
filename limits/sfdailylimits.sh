#!/bin/bash


#capture stdout
dxoutput=$(date ; sfdx force:limits:api:display -u blixtar | grep -v 'Concurrent' | grep -v 'Hourly' | grep -v 'SingleEmail'  | grep -v 'MassEmail' | grep -v 'Storage' | grep -v 'PermissionSets')

#scriptout=$($dxoutput > grep -v 'Hourly')

#this writes to stdout for this script
echo "${dxoutput}"