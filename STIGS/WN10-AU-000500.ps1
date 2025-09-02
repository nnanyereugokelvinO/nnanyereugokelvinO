# 
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Nnanyereugo Kelvin O
    LinkedIn        : linkedin.com/in//
    GitHub          : github.com/nnanyereugokelvinO
    Date Created    : 2025-09-01
    Last Modified   : 2025-09-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2025-08-29
    Tested By       : 
    Systems Tested  : endpoints
    PowerShell Ver. :  5.1.19041.6216

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

#
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set MaxSize value (DWORD) to 0x00008000 (32768 hexadecimal)
New-ItemProperty -Path $regPath -Name "MaxSize" -Value 0x8000 -PropertyType DWord -Force

# Read back the value for confirmation
$maxSize = Get-ItemProperty -Path $regPath -Name "MaxSize"
Write-Output "MaxSize is set to: $($maxSize.MaxSize) (decimal) | 0x$($maxSize.MaxSize.ToString('X')) (hex)"
