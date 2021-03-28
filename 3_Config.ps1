Import-Module -Name $PSScriptRoot\Debloat.psm1 -Force

# Limpieza Escritorio
Get-ChildItem -Path $HOME\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }
Get-ChildItem -Path C:\Users\Public\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }

# Iconos Escritorio
ShowUserFolderOnDesktop
ShowThisPCOnDesktop
ShowNetworkOnDesktop
ShowRecycleBinOnDesktop

# Orden iconos escritorio
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" -Name FFlags -Value "1075839525"

# Taskbar
Move-Item -Path "$PSScriptRoot\LayoutModification.xml" -Destination "C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"   

((Get-Content -path C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml -Raw) -replace 'Usuario', $env:UserName) | Set-Content -Path C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml

# Reiniciar Explorer
Stop-Process -ProcessName explorer

# NeoVim
git clone https://github.com/gastongmartinez/NeoVim "$env:UserProfile\Documents\NeoVim"
Invoke-Expression -Command "$env:UserProfile\Documents\NeoVim\install.ps1"

# Reinicio
$SN = Read-Host -Prompt "Se recomienda reiniciar el equipo, desea hacerlo ahora? (S/N): "
if ( $SN -eq "S" ) {
    Restart-Computer
}

