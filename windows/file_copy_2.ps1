$source = "D:\file2\userfile\lms"  # copy 
$destination = "C:\infra_backup\201009-10\file2\userfile\lms"  # save
$logFile = "C:\infra_backup\241009-10-file2-userfile-lms.txt"  # logsave
$startDate = Get-Date "2024-10-09"  # set date
$endDate = Get-Date "2024-10-10"  # end date


"copy start: $(Get-Date)" | Out-File $logFile 

# start
Get-ChildItem -Path $source -Recurse | Where-Object { $_.LastWriteTime -ge $startDate -and $_.LastWriteTime -lt $endDate } | ForEach-Object {
    $dest = $_.FullName -replace [regex]::Escape($source), $destination
    $fileDate = $_.LastWriteTime  
    if (-not (Test-Path $dest)) {
        try {
            
            if ($_.PSIsContainer) {
                New-Item -Path $dest -ItemType Directory | Out-Null
            } else {
                Copy-Item -Path $_.FullName -Destination $dest -Force
            }
            # log
            "Success : $($_.FullName) (date: $fileDate)" | Out-File $logFile -Append 
        } catch {
            "copy fail: $($_.FullName) - error: $_" | Out-File $logFile -Append 
        }
    } else {
        "Already existing: $dest (date: $fileDate) " | Out-File $logFile -Append 
    }
}

# end log
"copy end: $(Get-Date)" | Out-File $logFile -Append 
Write-Host "copy work end"
