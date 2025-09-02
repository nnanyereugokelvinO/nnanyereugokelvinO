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
    STIG-ID         : WN10-AC-0000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000005).ps1 
#>


#  Remediate Account Lockout Duration Policy
# Requirement: Account lockout duration must be >= 15 minutes OR 0 (admin unlock required)

# Desired value in minutes (set to 15 for compliance)
$LockoutDuration = 15

# Apply the policy using net accounts
net accounts /lockoutduration:$LockoutDuration

# Verify applied setting
Write-Output "Account lockout duration has been set to $LockoutDuration minutes."
