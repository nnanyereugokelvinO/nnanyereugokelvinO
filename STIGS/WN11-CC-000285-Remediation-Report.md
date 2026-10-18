# HealthSphere Cyber Range — Windows 11 STIG Remediation Report

## WN11-CC-000285 — Require secure RPC communication

**Asset:** `kelvin-stig-tes` (Windows 11 lab VM)  
**Benchmark:** DISA Microsoft Windows 11 STIG (Tenable audit)  
**Finding:** WN11-CC-000285 — The Remote Desktop Session Host must require secure RPC communications  
**Original Tenable status:** FAILED  
**Current status:** **Locally remediated and verified; Tenable rescan pending**

## Risk and requirement

Allowing unsecured Remote Procedure Call (RPC) communications to a Remote Desktop Session Host can expose communications to interception or manipulation. Tenable's remediation guidance requires the following policy to be **Enabled**:

`Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Security > Require secure RPC communication`

## Remediation performed

1. Located the policy under **Computer Configuration** in Local Group Policy Editor (`gpedit.msc`). An initial search under **User Configuration** did not display the Security category; the correct category was found under Computer Configuration.
2. Opened **Require secure RPC communication** and selected **Enabled**, then saved the policy.
3. Ran `gpupdate /force` in an elevated PowerShell session. Both **Computer Policy** and **User Policy** updates completed successfully.
4. Verified the resulting registry setting in PowerShell.

**Additional technical note:** Before locating the correct Group Policy path, the registry policy value was set directly to `1`. The setting was subsequently configured in the Group Policy editor and checked again after `gpupdate /force`.

## Verification

PowerShell command:

```powershell
Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "fEncryptRPCTraffic"
```

**Observed output:**

```text
1
```

The observed value `fEncryptRPCTraffic = 1` is consistent with the **Enabled** policy requirement. The successful `gpupdate /force` and the Group Policy editor screenshot provide additional local evidence. This does **not** establish that Tenable has marked the audit as PASSED; that requires a subsequent applicable, authenticated compliance scan.

## Evidence checklist

| Evidence | Status | Suggested filename |
|---|---|---|
| Original Tenable FAILED finding | Observed | `WN11-CC-000285-Tenable-Baseline-Failed.png` |
| Group Policy set to Enabled | Screenshot captured in session | `WN11-CC-000285-GroupPolicy-Enabled.png` |
| Successful `gpupdate /force` | Screenshot captured in session | `WN11-CC-000285-GPUpdate-Success.png` |
| Registry output `1` | Screenshot captured in session | `WN11-CC-000285-Registry-Verified.png` |
| Final Tenable compliance result | **Pending** | `WN11-CC-000285-Tenable-Rescan.png` |

*Screenshot filenames are suggested names for GitHub uploads; their presence in the repository has not yet been confirmed.*

## Follow-up after remediation batch

- Run the planned authenticated Tenable compliance rescan after completing the batch of STIG remediations.
- Check WN11-CC-000285 specifically and record the resulting PASS/FAIL status, scan date, and supporting screenshot.
- Update this same report with the final scan outcome; do not claim a verified Tenable PASS before the rescan.

## Portfolio note

This exercise demonstrates interpretation of a compliance finding, Windows Group Policy remediation, PowerShell-based validation, and evidence-based reporting for a remotely accessed Windows lab VM.
