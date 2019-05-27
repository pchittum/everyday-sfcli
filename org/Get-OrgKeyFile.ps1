<#

#>
Param(
    [Parameter(Mandatory, HelpMessage = "You must specify an org alias or username.")]
    [String]$OrgUserOrAlias,
    [Parameter(HelpMessage = "This parameter is only used for debugging to pass a fake command to test exceptions.")]
    [String]$CommandName = "sfdx"
)

#Check for sfdx installed function
Function Test-Sfdx {
<#
    function to test is sfdx exists as a command. 
    If not, we terminate the script. 
#>
    Try {
        $noop = Get-Command $CommandName -ErrorAction Stop
        
    } Catch {
        throw "Can't Find sfdx. Check if it is installed." 
    }
}

# run our function to see if sfdx is installed
# this here is a bit janky to create a function and then call it in the same script
# but trying to think ahead and move this function outside of this script later. 

Test-Sfdx

[String]$sfdx = "sfdx"
[String]$DxCommand = "force:org:display"
[String]$Params = "--verbose --json -u $OrgUserOrAlias"

$OrgNameFile = "$OrgUserOrAlias.txt"

# would be nice to be able to construct the command and eval it like with bash
$org = Invoke-Expression "$sfdx $DxCommand $Params" | ConvertFrom-Json

# get auth url and output to file 
# NOTE: Default file encoding for Out-File didn't make sfcli happy when passing char 
# string to store org creds. also new line char needed to be trimmed. 
Write-Output $org.result.sfdxAuthUrl | Out-File -FilePath $OrgNameFile -NoNewline -Encoding UTF8

Write-Output "Success. Wrote org auth key file $OrgNameFile"