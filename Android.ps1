$Applist = @(
    "dart-sdk"
    "flutter"
    "androidstudio"
    "android-sdk"
)

ForEach ($App in $Applist) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    choco install $App -y
}