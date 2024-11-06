
#@@@@@@@@@@@@@@@@@@@ IIS 웹서버 가상폴더 목록 확인 : 폴더 이름 추가 ver
Import-Module WebAdministration

$logFile = "C:\infra_mon\241106-2.txt"  
"Virtual Directory Listing - Start: $(Get-Date)" | Out-File $logFile

Get-ChildItem -Path IIS:\Sites | ForEach-Object {
    $site = $_
    
    $rootPath = Get-ItemProperty "IIS:\Sites\$($site.Name)" -Name physicalPath
    if ($rootPath -match "^\\\\|^[A-Z]:") {
        Write-Output "Site: $($site.Name), Root Path: $rootPath" | Out-File $logFile -Append
    }

    Get-ChildItem -Path "IIS:\Sites\$($site.Name)" | Where-Object { $_.PSIsContainer } | ForEach-Object {
        $virtualDirName = $_.Name
        $virtualPath = $_.physicalPath
        Write-Output "Site: $($site.Name), Virtual Directory: $virtualDirName, Path: $virtualPath" | Out-File $logFile -Append
    }
}

"Virtual Directory Listing - End: $(Get-Date)" | Out-File $logFile -Append
Write-Host "Virtual directory listing complete"
