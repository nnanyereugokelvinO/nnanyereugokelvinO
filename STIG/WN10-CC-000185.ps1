<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Nnanyereugo Kelvin O
    LinkedIn        : linkedin.com/in//
    GitHub          : github.com/nnanyereugokelvinO
    Date Created    : 2025-09-02
    Last Modified   : 2025-09-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000185

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000185).ps1 
#>

# Path to the registry key
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"

# Create the key if it does not exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the NoAutorun value to 1 (REG_DWORD)
Set-ItemProperty -Path $RegPath -Name "NoAutorun" -Value 1 -Type DWord

# Verify
$Result = Get-ItemProperty -Path $RegPath -Name "NoAutorun"
Write-Output "NoAutorun is set to: $($Result.NoAutorun)"
