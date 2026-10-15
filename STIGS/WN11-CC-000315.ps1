# STIG ID: WN11-CC-000315
# Title: Windows Installer - Always install with elevated privileges must be disabled.
# Purpose: Configure and verify the registry policy at machine and current-user scope.
# Run from an elevated Windows PowerShell session. HKCU applies to the executing user.
# Note: This script is a reproducible remediation example, not proof it was executed.

$ErrorActionPreference = 'Stop'
$policyPaths = @(
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer',
    'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer'
)

foreach ($path in $policyPaths) {
    if (-not (Test-Path -LiteralPath $path)) {
        New-Item -Path $path -Force | Out-Null
    }
    New-ItemProperty -Path $path -Name 'AlwaysInstallElevated' -PropertyType DWord -Value 0 -Force | Out-Null
}

Write-Host 'Verification results:'
foreach ($path in $policyPaths) {
    $value = (Get-ItemProperty -Path $path -Name 'AlwaysInstallElevated').AlwaysInstallElevated
    $scope = if ($path.StartsWith('HKLM:')) { 'HKLM' } else { 'HKCU' }
    Write-Host "$scope : $value"
    if ($value -ne 0) { throw "Verification failed for $scope" }
}
Write-Host 'Local registry verification PASSED. Nessus compliance rescan is separate and pending.'
