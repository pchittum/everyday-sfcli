<#

#>
Param(
    [Parameter(Mandatory, HelpMessage = "You must specify a value here")]
    [String]$MandatoryParam,
    [Parameter(HelpMessage = "This parameter is optional")]
    [String]$OptionalParam = "Default Value"
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

# run our function to see if sfdx is installed
# this here is a bit janky to create a function and then call it in the same script
# but trying to think ahead and move this function outside of this script later. 

Test-Sfdx

# replace $DxCommand and $Params 
[String]$sfdx = "sfdx"
[String]$DxCommand = "force:org:list"
[String]$Params = "--verbose --json"
[string]$OutputFilename = "OutputFile"
[string]$OutputFileExtension = ".txt"
[string]$OutputFilePath = "."

$FullOutputPath = Join-Path -Path $OutputFilePath -ChildPath "$OutputFilename$OutputFileExtension"

# eval the resulting sfdx command expression
# we've gone for JSON by default. so easy to handle in powershell
$CmdOutput = Invoke-Expression "$sfdx $DxCommand $Params" | ConvertFrom-Json

# writing output to file 
# typically JSON from sfdx commands has a result top level node that we will take some data from
Write-Output $CmdOutput.result | Out-File -FilePath $FullOutputPath -NoNewline -Encoding UTF8

Write-Output "Success. Wrote org auth key file $FullOutputPath"