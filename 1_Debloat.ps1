Import-Module -Name $PSScriptRoot\Debloat.psm1 -Force

$SN = Read-Host -Prompt "Al finalizar se reiniciara el equipo, desea continuar? (S/N)"
if ( $SN -eq "N" ) {
    exit
}

UnpinTaskbarEdgeStore

# Comentar para omitir
$MSApss = @(
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MixedReality.Portal"
    "Microsoft.News"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Lens"
    "Microsoft.Office.Sway"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"               
    "Microsoft.WindowsMaps"                      
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "SpotifyAB.SpotifyMusic"
    "Microsoft.SkypeApp"
)

RemoveApps $MSApss

DesinstalarOneDrive

# Bloat
WindowsWelcomeExperience
WindowsTips
SettingsSuggestedContent
WhatsNewInWindows
BingSearch

# Privacidad
DisableTelemetry
DisableActivityHistory
DisableBackgroundApps
DisableLocationTracking
DisableFeedback
DisableTailoredExperiences
DisableAdvertisingID
DisableCortana
DisableErrorReporting
DisableDiagTrack

# Configuraciones Varias
HideTaskbarSearch
HideTaskView
UnpinStartMenuTiles
DisableShareAcrossDevices
PowerManagementScheme
Hibernate
FileTransferDialog
FileExplorerRibbon
ControlPanelView
RecentlyAddedApps
AppSuggestions
TaskManagerWindow
HideRecycleBinOnDesktop


Restart-Computer