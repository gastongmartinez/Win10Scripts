New-Item -Path "c:\" -Name "flutter" -ItemType "directory"
git clone https://github.com/flutter/flutter.git -b stable "c:\flutter"

[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User) + ";C:\flutter\bin", [EnvironmentVariableTarget]::User)

flutter doctor
