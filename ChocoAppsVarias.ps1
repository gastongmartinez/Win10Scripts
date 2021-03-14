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
    "emacs-full"
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
)

ForEach ($App in $Applist) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    choco install $App -y
}


Write-Output "Reinicie el equipo"