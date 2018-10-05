#!/bin/bash


#capture stdout
dxoutput=$(sfdx force:limits:api:display -u blixtar)

#scriptout=$($dxoutput > grep -v 'Hourly')

#this writes to stdout for this script
echo "${dxoutput}"
exit 0
