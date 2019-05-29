<#

#>
Param(
    [Parameter(Mandatory, HelpMessage = "You must specify an org alias or username.")]
    [String]$OrgUserOrAlias,
    [Parameter(HelpMessage = "This parameter is only used for debugging to pass a fake command to test exceptions.")]
    [String]$CommandName = "sfdx"
)

Test-Sfdx

[String]$sfdx = "sfdx"
[String]$DxCommand = "force:org:display"

# construct parameters and create params string
[string]$AdminUser = Format-SfdxParamAndValue -ParamName '-u' -ParamValue $OrgUserOrAlias

[String]$Params = "--verbose --json $AdminUser"

$OrgNameFile = "$OrgUserOrAlias.txt"

# would be nice to be able to construct the command and eval it like with bash
$org = Invoke-Expression "$sfdx $DxCommand $Params" | ConvertFrom-Json

# get auth url and output to file 
# NOTE: Default file encoding for Out-File didn't make sfcli happy when passing char 
# string to store org creds. also new line char needed to be trimmed. 
Write-Output $org.result.sfdxAuthUrl | Out-File -FilePath $OrgNameFile -NoNewline -Encoding UTF8

Write-Output "Success. Wrote org auth key file $OrgNameFile"