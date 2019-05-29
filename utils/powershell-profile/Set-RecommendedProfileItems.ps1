cd ~

# Convenience functions to speed up common basic sfdx commands that run 
# against defaultusername orgs
Function dxopen ([string]$u) {
    If ($u -ne '') {
        sfdx force:org:open -u $u     
    } Else {
        sfdx force:org:open
    }
}
Function dxlist {sfdx force:org:list}
Function dxpush {sfdx force:source:push}
Function dxpull {sfdx force:source:pull}
Function dxdeploy {sfdx force:source:deploy}
Function dxretrieve {sfdx force:source:retrieve}
Function dxprerel {sfdx plugins:install @salesforcedx@pre-release}
Function dxga {
    sfdx plugins:uninstall salesforcedx
    sfdx update
}


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

    Try {
        $noop = Get-Command Format-SfdxParamAndValue -ErrorAction Stop
    } Catch {
        throw "The Format-SfdxParamAndValue function is not available in the current shell."
    }

}

Function Format-SfdxParamAndValue ([String]$ParamName, [String]$ParamValue){

    <#
    For executing sfdx scripts to convert parameter values into a string that includes the sfdx parameter name
    and value. If no value is specified return an empty string. This way, if called, 
    #>

    If ($ParamValue -ne '') {
        Return "$ParamName $ParamValue"
    } Else {
        Return ''
    }
}

