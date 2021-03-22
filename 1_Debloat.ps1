Function RemoveAppsCapabilities {
    # Comentar para omitir
    $Applist = @(
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
    )

    $Capabilities = @(
        "App.Support.QuickAssist~~~~0.0.1.0"
    )
    $Logfile = "$env:SystemRoot\Temp\LimpiezaApps.log"
    Set-Content -Path $Logfile -Value "Remove builtin apps based on $Applist"

    ForEach ($App in $Applist) {
        $App = $App.TrimEnd()
        $PackageFullName = (Get-AppxPackage $App).PackageFullName
        $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object { $_.Displayname -eq $App }).PackageName

        if ($PackageFullName) {
            "`r`nRemoving Package: $App" | Out-File -FilePath $Logfile -Append -Encoding ascii
            start-sleep -Seconds 5
            remove-AppxPackage -package $PackageFullName | Out-File -FilePath $Logfile -Append -Encoding ascii
        }
        else {
            "Unable to find package: $App" | Out-File -FilePath $Logfile -Append -Encoding ascii 
        }

        if ($ProPackageFullName) {
            "`r`nRemoving Provisioned Package: $ProPackageFullName" | Out-File -FilePath $Logfile -Append -Encoding ascii
            start-sleep -Seconds 5 
            Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName | Out-File -FilePath $Logfile -Append -Encoding ascii  
        }
        else {
            "Unable to find provisioned package: $App" | Out-File -FilePath $Logfile -Append -Encoding ascii
        }
    }

    ForEach ($Capability in $Capabilities) {
        "`r`nRemoving capability: $Capability".Replace("  ", " ") | Out-File -FilePath $Logfile -Append 
        Remove-WindowsCapability -online -name $Capability | Out-File -FilePath $Logfile -Append -Encoding ascii
    }

    Get-Content -Path $Logfile
}


Function DesinstalarOneDrive {
    Write-Output "Desinstalando OneDrive..."
    Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    If (!(Test-Path $onedrive)) {
        $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
    Start-Sleep -s 2
    Stop-Process -Name "explorer" -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
    If (!(Test-Path "HKCR:")) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
}

# Comentar para omitir
$Bloat = @(
    "WindowsWelcomeExperience",
    "WindowsTips",
    "SettingsSuggestedContent",
    "WhatsNewInWindows",
    "BingSearch",
    "UnpinTaskbarEdge"
)
Function WindowsWelcomeExperience {
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-310093Enabled -PropertyType DWord -Value 0 -Force
}

Function WindowsTips {
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-338389Enabled -PropertyType DWord -Value 0 -Force        
}

Function SettingsSuggestedContent {
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-338393Enabled -PropertyType DWord -Value 0 -Force
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-353694Enabled -PropertyType DWord -Value 0 -Force
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-353696Enabled -PropertyType DWord -Value 0 -Force
}

Function WhatsNewInWindows {
    if (-not (Test-Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement)) {
        New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement -Force
    }
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement -Name ScoobeSystemSettingEnabled -PropertyType DWord -Value 0 -Force
}

Function BingSearch {
    if (-not (Test-Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer)) {
        New-Item -Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Force
    }
    New-ItemProperty -Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -PropertyType DWord -Value 1 -Force
}

Function UnpinTaskbarEdge {
    $Signature = @{
        Namespace        = "WinAPI"
        Name             = "GetStr"
        Language         = "CSharp"
        MemberDefinition = @"
	[DllImport("kernel32.dll", CharSet = CharSet.Auto)]
	public static extern IntPtr GetModuleHandle(string lpModuleName);
	[DllImport("user32.dll", CharSet = CharSet.Auto)]
	internal static extern int LoadString(IntPtr hInstance, uint uID, StringBuilder lpBuffer, int nBufferMax);
	public static string GetString(uint strId)
	{
		IntPtr intPtr = GetModuleHandle("shell32.dll");
		StringBuilder sb = new StringBuilder(255);
		LoadString(intPtr, strId, sb, sb.Capacity);
		return sb.ToString();
	}
"@
    }
    if (-not ("WinAPI.GetStr" -as [type])) {
        Add-Type @Signature -Using System.Text
    }

    # Extract the localized "Unpin from taskbar" string from shell32.dll
    $LocalizedString = [WinAPI.GetStr]::GetString(5387)
    $Apps = (New-Object -ComObject Shell.Application).NameSpace("shell:::{4234d49b-0245-4df3-b780-3893943456e1}").Items()
    $VerbExists = $Apps | Where-Object -FilterScript { $_.Path -eq "MSEdge" } | ForEach-Object -Process { $_.Verbs() | Where-Object -FilterScript { $_.Name -eq $LocalizedString } }
    if ($VerbExists) {
        $VerbExists | ForEach-Object -Process { $_.DoIt() }
    }
    else {
        Remove-Item -Path "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" -ErrorAction Ignore
        $VerbExists | ForEach-Object -Process { $_.DoIt() }
    }
}

# Comentar para omitir
RemoveAppsCapabilities
DesinstalarOneDrive

# Call the desired Bloat functions
$Bloat | ForEach-Object { Invoke-Expression $_ }

