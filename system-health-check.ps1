# Project: MSP IT Support Automation
# Purpose: Collect basic Windows troubleshooting information.
# Environment: Windows 10/11

$ReportPath = Join-Path $PSScriptRoot "health-report.txt"

function Write-Report {
    param([string]$Message)

    Add-Content -Path $ReportPath -Value $Message
}

"====================================" | Set-Content $ReportPath
Write-Report "MSP SYSTEM HEALTH REPORT"
Write-Report "Computer: $env:COMPUTERNAME"
Write-Report "Date: $(Get-Date)"
Write-Report "===================================="

# 1. Network connectivity

Write-Report "`n[1] NETWORK CONNECTIVITY"

try {
    $null = Test-Connection `
        -ComputerName "1.1.1.1" `
        -Count 2 `
        -ErrorAction Stop

    Write-Report "PASS: Destination responded to ping."
}
catch {
    Write-Report "WARNING: Ping failed. Investigate connectivity or ICMP filtering."
}

# 2. DNS resolution

Write-Report "`n[2] DNS RESOLUTION"

try {
    $null = Resolve-DnsName `
        -Name "microsoft.com" `
        -ErrorAction Stop

    Write-Report "PASS: DNS resolution succeeded."
}
catch {
    Write-Report "FAIL: DNS resolution failed."
}

# 3. Disk space

Write-Report "`n[3] DISK SPACE"

try {
    $Disks = Get-CimInstance Win32_LogicalDisk `
        -Filter "DriveType=3" `
        -ErrorAction Stop

    foreach ($Disk in $Disks) {
        if ($Disk.Size -gt 0) {
            $FreeGB = [math]::Round(
                $Disk.FreeSpace / 1GB, 2
            )

            $TotalGB = [math]::Round(
                $Disk.Size / 1GB, 2
            )

            $FreePercent = [math]::Round(
                ($Disk.FreeSpace / $Disk.Size) * 100, 1
            )

            Write-Report (
                "$($Disk.DeviceID): $FreeGB GB free " +
                "of $TotalGB GB ($FreePercent% free)"
            )

            if ($FreePercent -lt 15) {
                Write-Report (
                    "WARNING: Low disk space on " +
                    "$($Disk.DeviceID)"
                )
            }
        }
    }
}
catch {
    Write-Report "FAIL: Could not retrieve disk information."
}

# 4. Windows service status

Write-Report "`n[4] WINDOWS SERVICES"

$ServiceNames = @(
    "EventLog",
    "Dnscache",
    "Spooler"
)

foreach ($Name in $ServiceNames) {
    try {
        $Service = Get-Service `
            -Name $Name `
            -ErrorAction Stop

        Write-Report (
            "$Name : $($Service.Status)"
        )
    }
    catch {
        Write-Report (
            "WARNING: Could not retrieve service $Name."
        )
    }
}

# 5. Report completion

Write-Report "`nReport completed: $(Get-Date)"

Write-Host "Health check completed."
Write-Host "Report saved to: $ReportPath"