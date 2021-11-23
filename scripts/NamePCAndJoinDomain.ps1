$machinename = Read-Host "Name this machine"
Rename-Computer -NewName $(machinename)
Add-Computer -DomainName loopunit.lan -Credential loopunit.lan\lu_admin
