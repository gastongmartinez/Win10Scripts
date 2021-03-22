Write-Output "Instalando Paquetes Varios"
# Comentar para omitir
$Applist = @(
    "brave"
    "googlechrome"
    "teamviewer"
    "qbittorrent"
    "drawio"
    "yed"
    "krita"
    "blender"
    "inkscape"
    "gimp"
    "freecad"
    "vlc"
    "mpv" 
    "winscp"
    "glaryutilities-free"
    "calibre"
    "neovim"
    #"emacs-full"
    "etcher"
    "codeblocks"
    "filezilla"
    "f.lux"
    "microsoft-windows-terminal"
    "powershell-core"
    "handbrake"
    "coretemp"
    "libreoffice-fresh"
    "shellcheck"
    "font-awesome-font"
    "alacritty"
    "joplin"
    "nodejs"
    "virtualbox"
)

ForEach ($App in $Applist) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    choco install $App -y
}

Get-ChildItem -Path $HOME\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }
Get-ChildItem -Path C:\Users\Public\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }

Write-Output "Reinicie el equipo"
