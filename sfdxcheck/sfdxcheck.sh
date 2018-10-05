#!/bin/bash -x 
# utility script to check for sfdx binary installation

if [[ -e $(which sfdx) ]]; then
  
  exit 0

else

  exit 1

fi 