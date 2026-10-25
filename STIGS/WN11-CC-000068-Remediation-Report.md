# Windows 11 DISA STIG Remediation Report

## STIG ID: WN11-CC-000068

**Finding:** Windows 11 must be configured to enable Remote host allows delegation of non-exportable credentials.

**Vulnerability ID:** V-253368  
**Rule ID:** SV-253368r991589_rule  
**Severity:** CAT II (Medium)  
**Audit Source:** Tenable — DISA_STIG_Microsoft_Windows_11_v2r9.audit  
**Environment:** Windows 11 Cyber Range Lab  
**Remediation Date:** 25 October 2026  

### 1. Initial Finding

The original Tenable compliance scan reported this control as **FAILED**.

The Windows Group Policy setting **Remote host allows delegation of non-exportable credentials** was inspected and found to be **Not Configured**.

This configuration did not meet the DISA STIG requirement.

### 2. Security Risk

Credential delegation can expose reusable credentials to theft on remote systems.

Enabling this policy allows the remote host to support Restricted Admin mode and Remote Credential Guard, helping reduce credential exposure during supported remote authentication scenarios.

### 3. Required Configuration

**Group Policy path:**

Computer Configuration → Administrative Templates → System → Credentials Delegation → Remote host allows delegation of non-exportable credentials

**Required setting:** Enabled  
**Expected policy value:** 1

### 4. Remediation Performed

The following remediation steps were completed:

1. Opened Local Group Policy Editor (`gpedit.msc`).
2. Navigated to the Credentials Delegation policy.
3. Confirmed the original setting was Not Configured.
4. Changed the policy to Enabled.
5. Applied the configuration.
6. Executed the following command in PowerShell:

```powershell
gpupdate /force
```

PowerShell confirmed:

```text
Computer Policy update has completed successfully.
User Policy update has completed successfully.
```

### 5. Independent Verification

The following PowerShell command was executed:

```powershell
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Name AllowProtectedCreds
```

**Actual observed result:**

```text
AllowProtectedCreds : 1
```

This matches the required policy value.

An earlier registry query using a different path returned no result. Subsequent investigation identified the correct policy registry location.

**Local verification result: PASS**

This confirms the configured registry policy value. It does not independently establish that Remote Credential Guard was exercised during an actual remote session.

### 6. Evidence

The following screenshots were captured during remediation:

| Evidence file | Description |
|---|---|
| WN11-CC-000068-Before.png | Original Group Policy setting: Not Configured |
| WN11-CC-000068-Enabled.png | Remediated Group Policy setting: Enabled |
| WN11-CC-000068-Policy-Refresh.png | Successful Computer and User Group Policy refresh |
| WN11-CC-000068-Registry-Verified.png | Registry verification showing AllowProtectedCreds = 1 |

Screenshot filenames are the intended GitHub evidence names. Repository upload and verification remain to be completed.

### 7. Remediation Outcome

| Verification item | Result |
|---|---|
| Original Tenable finding | FAILED |
| Group Policy configuration | Enabled |
| Group Policy refresh | Successful |
| Registry value | AllowProtectedCreds = 1 |
| Local remediation verification | PASS |
| Post-remediation Tenable scan | Pending |

### 8. Outstanding Action

Perform the final authenticated Tenable compliance rescan after completing the planned Windows 11 STIG remediation work.

Compare the new scan results against the original baseline of:

- Total compliance checks: 258
- Failed: 151
- Warnings: 11
- Passed: 96

Retain the original and post-remediation results for audit evidence.

### 9. Final Assessment

**Status: Remediated — Locally Verified**

The required Group Policy configuration was enabled, Group Policy refreshed successfully, and the expected registry value was independently confirmed.

**Tenable-confirmed compliance remains pending until the final authenticated rescan.**

---

*Private Windows 11 DISA STIG Cyber Range Remediation Project — Evidence-based security configuration and verification.*
