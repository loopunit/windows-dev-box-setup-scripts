# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "sophia/Sophia.ps1";

#--- Tools ---
#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2022Community

choco install -y git
choco install -y cmake

Update-SessionEnvironment

#choco install -y visualstudio2022community
#choco install -y visualstudio2022-workload-nativedesktop
#choco install -y visualstudio2022-workload-nativegame
#choco install -y visualstudio2022-workload-vctools
#choco install visualstudio2022-workload-nativecrossplat


#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
