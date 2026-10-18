# HealthSphere Innovations — Windows 11 STIG WN11-CC-000110

**Control:** Printing over HTTP must be prevented  
**STIG identifier:** WN11-CC-000110 / V-253376 (CAT II / Medium)  
**Report reviewed:** 18 October 2026  
**Lab outcome:** Local registry value verified; Nessus rescan still pending.

## Security requirement

Windows should be configured to prevent the client from printing over HTTP. The prescribed machine-level registry configuration is:

| Property | Required value |
| --- | --- |
| Hive | `HKEY_LOCAL_MACHINE` |
| Key | `SOFTWARE\Policies\Microsoft\Windows NT\Printers` |
| Value | `DisableHTTPPrinting` |
| Type | `REG_DWORD` |
| Data | `1` |

This supports endpoint hardening and reduces unnecessary printing-related network exposure. [Windows 11 STIG control reference](https://www.stigaview.com/products/win11/v2r11/onepage/) and [Microsoft policy documentation](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-connectivity).

## Observed verification evidence

The lab screenshot saved in this repository shows PowerShell output from the relevant machine-level registry path with:

```text
DisableHTTPPrinting : 1
PSPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers
```

![PowerShell registry screenshot](WN11-CC-000110-evidence.png)

**Evidence:** [`WN11-CC-000110-evidence.png`](WN11-CC-000110-evidence.png)

**Interpretation:** The local registry value matched the required value at the time of verification. The screenshot does not independently prove when or how the setting was changed or that a follow-up compliance scanner has passed.

## How to verify on an authorised lab system

The following command reads the setting without changing it:

```powershell
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers' -Name 'DisableHTTPPrinting' |
    Select-Object DisableHTTPPrinting
```

Expected output: `DisableHTTPPrinting` is `1`. The command above is provided as a repeatable check; the screenshot alone does not establish that this precise command was used.

## Reference remediation procedure

If an authorised machine is found non-compliant, use approved change management to configure:

**Computer Configuration → Administrative Templates → System → Internet Communication Management → Internet Communication settings → Turn off printing over HTTP → Enabled**.

Refresh policy if appropriate, verify the value, and assess legitimate printing workflows before wider deployment. This is a reference procedure; the stored evidence does **not** document every step of the original remediation.

## Verification status

| Check | Status | Evidence |
| --- | --- | --- |
| Machine registry value `DisableHTTPPrinting = 1` | **Locally verified** | Saved PowerShell screenshot |
| Full before/after remediation sequence | **Not established** | Requires separate change log |
| Authenticated Nessus STIG rescan | **Pending** | No confirmed post-change report |
| Production healthcare deployment or compliance | **Not assessed** | Training lab only |

**Next action:** Run the planned authenticated Nessus rescan, compare with the October 13 baseline, and record the control-specific outcome. Do not label this item *Nessus passed* until that evidence exists.

## Application to healthcare IT consulting

Healthcare organisations should control unnecessary endpoint communication paths while ensuring legitimate clinical printing continues to function. This exercise illustrates a consultant's workflow: identify a security requirement, assess configuration evidence, validate the result, document limitations, and recommend an independently verifiable next step. The setting alone does not establish HIPAA compliance.

## Questions I should be able to answer

1. **Why does this control exist?** To prevent Windows client printing over HTTP and reduce unnecessary connectivity.
2. **Which value is required?** A DWORD named `DisableHTTPPrinting`, set to `1` under the specified HKLM registry path.
3. **What does the evidence establish?** The captured PowerShell registry reading, not a completed Nessus rescan.
4. **What remains?** Scanner confirmation, an auditable change sequence, and impact evaluation before recommending production rollout.

---

**Project:** HealthSphere Innovations — Cyber Range / Windows 11 STIG portfolio.  
**Scope:** Authorised training lab, using configuration evidence only; no patient or production data.
