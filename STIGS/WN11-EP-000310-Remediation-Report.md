# WN11-EP-000310 — Windows 11 Kernel DMA Protection Remediation Report

## STIG Information
- **STIG ID:** WN11-EP-000310
- **Vulnerability ID:** V-253426
- **Severity:** CAT II
- **Audit:** DISA STIG Microsoft Windows 11 V2R9
- **Initial Tenable Result:** FAILED
- **Initial Policy Value:** 0

## Finding
Windows 11 must configure the enumeration policy for external devices incompatible with Kernel Direct Memory Access (DMA) Protection to block all incompatible external devices.

## Remediation Performed
1. Opened Local Group Policy Editor (`gpedit.msc`).
2. Navigated to Computer Configuration → Administrative Templates → System → Kernel DMA Protection.
3. Opened **Enumeration policy for external devices incompatible with Kernel DMA Protection**.
4. Changed the setting from **Not Configured** to **Enabled**.
5. Selected **Block all**.
6. Applied the policy and ran `gpupdate /force`.

## Verification
The Group Policy refresh completed successfully for both Computer Policy and User Policy.

PowerShell registry verification:

`HKLM:\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection`

Observed result:

`DeviceEnumerationPolicy : 0`

This value corresponds to the configured **Block all** enumeration policy.

## Evidence
- WN11-EP-000310-Before.png
- WN11-EP-000310-Enabled.png
- WN11-EP-000310-Policy-Refresh.png
- WN11-EP-000310-Registry-Verified.png

## Final Assessment
**Local policy configuration: PASS**

**Authenticated Tenable rescan: PENDING**

This report confirms the observed Group Policy configuration and registry value. It does not independently establish hardware-level Kernel DMA Protection support or a scanner-confirmed PASS.
