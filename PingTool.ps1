Write-Host "=== Network Stability Monitor ===" -ForegroundColor Magenta
# Settings
$hostToPing = "8.8.8.8"       # This is Google's DNS (very reliable)
$pingCount = 4                # How many times to ping each cycle
$interval = 10                # Seconds between each test
$logFile = "ping_log.txt"     # File to save results
while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $result = Test-Connection -ComputerName $hostToPing -Count $pingCount -Quiet

    if ($result) {
        $logEntry = "$timestamp - SUCCESS: $hostToPing is reachable."
        Write-Host $logEntry -ForegroundColor Green
    } else {
        $logEntry = "$timestamp - FAILURE: $hostToPing is not reachable."
        Write-Host $logEntry -ForegroundColor Red
    }

    Add-Content -Path $logFile -Value $logEntry
    Start-Sleep -Seconds $interval
}
