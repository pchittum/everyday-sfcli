<#
    Deactivate a user based on Salesforce username. 
#>
Param(
    [Parameter(Mandatory, HelpMessage = "Specify a salesforce username in the format of an email address: username@to.deactivate")]
    [String]$UserToDeactivate,
    [Parameter(HelpMessage = "Specify a username or org alias on which to run this command. ")]
    [String]$OrgUserOrAlias
)

#Script Dependencies: These two functions are commented out. The script will work if you've
# added them as functions to your PowerShell profile. 
# Function Test-Sfdx {
# <#
#     function to test is sfdx exists as a command. 
#     If not, we terminate the script. 
# #>
#     Try {
#         $noop = Get-Command sfdx -ErrorAction Stop 
#     } Catch {
#         throw "Can't Find sfdx. Check if it is installed." 
#     }
#     Try {
#         $noop = Get-Command Format-SfdxParamAndValue -ErrorAction Stop
#     } Catch {
#         throw "The Format-SfdxParamAndValue function is not available in the current shell."
#     }
# }
# Function Format-SfdxParamAndValue ([String]$ParamName, [String]$ParamValue){
#     If ($ParamValue -ne '') {
#         Return "$ParamName $ParamValue"
#     } Else {
#         Return ''
#     }
# }

# run our function to see if sfdx is installed

Test-Sfdx

# replace $DxCommand and $Params 
[String]$sfdx = "sfdx"
[String]$DxCommand = "force:data:record:update"

# construct params to pass
[string]$AdminUser = Format-SfdxParamAndValue -ParamName '-u' -ParamValue $OrgUserOrAlias
[string]$WhereFlag = Format-SfdxParamAndValue -ParamName '-w' -ParamValue "Username=$UserToDeactivate"
[string]$Sobject = '-s User'
[string]$Values = '-v IsActive=false'

[String]$Params = "--json $Sobject $AdminUser $WhereFlag $Values"

# eval the resulting sfdx command expression
# we've gone for JSON by default. so easy to handle in powershell

$RawResult = Invoke-Expression -Command "$sfdx $DxCommand $Params" | ConvertFrom-Json 

if ($RawResult.status -eq 0) {
    $RawResult.result 
    Write-Output "Update Complete. User $UserToDeactivate"
} else {
    throw "sfdx failed to execute correctly. Check the log."
}


#
# $CmdOutput = Invoke-Expression "$sfdx $DxCommand $Params" | ConvertFrom-Json
# $CmdOutput.result
# writing output to file 
# typically JSON from sfdx commands has a result top level node that we will take some data from
# Write-Output $CmdOutput.result | Out-File -FilePath $FullOutputPath -NoNewline -Encoding UTF8
# Write-Output "Success. Wrote org auth key file $FullOutputPath"
#