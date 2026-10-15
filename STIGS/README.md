# WN11-CC-000315 — Windows 11 STIG Remediation

**Finding:** The Windows Installer policy **Always install with elevated privileges** must be disabled.

**Risk:** Enabling this setting at both computer and user scopes can permit Windows Installer packages to run with elevated privileges, creating an avoidable privilege-escalation risk.

## Remediation documented

In Local Group Policy Editor, **Always install with elevated privileges** was set to **Disabled** at both:

- `Computer Configuration > Administrative Templates > Windows Components > Windows Installer`
- `User Configuration > Administrative Templates > Windows Components > Windows Installer`

Policy refresh was run using `gpupdate /force`.

## Verification

Windows PowerShell registry verification showed:

```text
HKLM : 0
HKCU : 0
```

The attached screenshots show both Group Policy settings and the registry results. This confirms the **local configuration**. A **Nessus STIG compliance rescan has not yet been evidenced**, so scanner compliance is **pending**, not claimed as passed.

## Evidence

- `evidence/registry-verification.png` — PowerShell values at HKLM and HKCU.
- `evidence/group-policy-computer.png` — Computer Configuration policy set to Disabled.
- `evidence/group-policy-user.png` — User Configuration policy set to Disabled.

## Script

`WN11-CC-000315.ps1` provides a reproducible example that sets the registry DWORD `AlwaysInstallElevated` to `0` at HKLM and HKCU and verifies the result. **The provided evidence demonstrates the manual Group Policy remediation, not execution of this script.** HKCU affects the account running the script; enterprise deployment requires appropriate user-context targeting.

**Project:** HealthSphere Cyber Range & Threat Hunting  
**Date documented:** 15 October 2026
