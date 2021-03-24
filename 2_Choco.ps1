Write-Output "Instalando Chocolatey"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Instalando Paquetes Base"
# Comentar para omitir
$Applist = @(
    "poweriso"
    "vscode"
    "firefox"
    "openjdk"
    "powertoys"
    "git"
    "python"
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


