$source = "A:\file1\file\lms\alex\speakout"  # copy 
$destination = "Z:\file\lms\alex\speakout"  # save
$logFile = "C:\infra_back\logs_new\CtoD-alex.txt"  # logsave
$date = Get-Date "2024-09-01"  # set date


"copy start: $(Get-Date)" | Out-File $logFile 

# start
Get-ChildItem -Path $source -Recurse | Where-Object { $_.LastWriteTime -gt $date } | ForEach-Object {
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
            "copy fail : $($_.FullName) - error: $_" | Out-File $logFile -Append 
        }
    } else {
        "Already existing: $dest (date: $fileDate) " | Out-File $logFile -Append 
    }
}

# end log
"copy end: $(Get-Date)" | Out-File $logFile -Append 
Write-Host "copy work end"
