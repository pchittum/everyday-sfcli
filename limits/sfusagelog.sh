#!/bin/bash


#capture stdout
dxoutput=$(sfdx force:limits:api:display -u blixtar | grep -v 'Hourly' | grep -v 'Concurrent' | grep -v 'Daily' | grep -v 'Email' | grep -v 'Package')

#scriptout=$($dxoutput > grep -v 'Hourly')

#this writes to stdout for this script
echo date >> log-output/usage.log
echo "${dxoutput}" >> log-output/usage.log
exit 0
