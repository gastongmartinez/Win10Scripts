#Limpieza Escritorio
Get-ChildItem -Path $HOME\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }
Get-ChildItem -Path C:\Users\Public\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }