<#
    Retrieve org limits data and format for display
#>

Param(
    [Parameter(HelpMessage = "Provide an optional org alias or username.")]
    [String]$OrgUserOrAlias,
    [Parameter(HelpMessage = "Currently not implemented and always shows lowest capacity items at top.")]
    [bool]$MostUsedAtTop = $false
)

#Check for sfdx installed function
Function Test-Sfdx {
<#
    function to test is sfdx exists as a command. 
    If not, we terminate the script. 
#>
    Try {
        $noop = Get-Command sfdx -ErrorAction Stop
        
    } Catch {
        throw "Can't Find sfdx. Check if it is installed." 
    }
}

Function Format-ParamAndValue ([String]$ParamName, [String]$ParamValue){
    If ($ParamValue -ne '') {
        Return "$ParamName $ParamValue"
    } Else {
        Return ''
    }
}

# run our function to see if sfdx is installed
# this here is a bit janky to create a function and then call it in the same script
# but trying to think ahead and move this function outside of this script later. 

Test-Sfdx

# replace $DxCommand and $Params 
[String]$sfdx = "sfdx"
[String]$DxCommand = "force:limits:api:display"

# build params

$AdminUser = Format-ParamAndValue -ParamName '-u' -ParamValue $OrgUserOrAlias

[String]$Params = "--json $AdminUser"

$RawResult = Invoke-Expression -Command "$sfdx $DxCommand $Params" | ConvertFrom-Json 

if ($RawResult.status -eq 0) {
    $RawResult.result | Select-Object Name, Max, Remaining, @{Name="PctRemain"; Expression={[math]::Round( 100 * ($_.Remaining / $_.Max), 2)}} | Sort PctRemain
} else {
    throw "sfdx failed to execute correctly. Check the log."
}