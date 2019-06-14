# Apply the Salesforce CLI to Everyday Problems

Source repo for talk at Dreamforce 2018 and TrailheaDX 2019 by Peter Chittum

## What Is This?
The foundational tool of the Salesforce DX features and tools is the Salesforce CLI. 
...more to come...

## PowerShell

PowerShell scripts are provided for Windows users. Scripts were developed on PSVersion 5.1. 

### Setting PowerShell Profile

To work with the PowerShell scripts as defined here, you'll want to add items from the `Set-RecommendedProfileItems.ps1` [script](https://github.com/pchittum/everyday-sfcli/blob/master/powershell-profile/Set-RecommendedProfileItems.ps1) to your powershell profile. I'd recommended using the `$profile.CurrentUserAllHosts` profile script to ensure that they are used anytime PowerShell is run. 

If you don't already have a script in place for your PowerShell profile, you can add one as follows. 

Open the PowerShell Integrated Scripting Environment (ISE). Easiest way to do that is to tap the Window button and type _ISE_. 

1. First, check to make sure you don't already have a profile script. 

    C:\> ise $profile.CurrentUserAllHosts

1. If you receive an error to the effect of _Unable to load...Could not find file_, you need to create your profile script. Fortunately PowerShell already has a system variable that points to the non-existent profile script. So you can create it as follows and then repeat the command above to open it. 

    C:\> New-Item $profile-CurrentUserAllHosts
    C:\> ise $profile.CurrentUserAllHosts

It should now be open and ready to go. Go back to the `Set-RecommendedProfileItems.ps1` and you can copy/paste the functions in. 

Relaunch any active PowerShell sessions for the new profile settings to take effect. 