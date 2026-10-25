# Windows 11 DISA STIG Remediation Report

## STIG ID: WN11-CC-000255

**Finding:** The use of a hardware security device with Windows Hello for Business must be enabled.

**Severity:** CAT II (Medium)  
**Original Tenable Audit Status:** FAILED  
**Current Remediation Status:** Locally verified — PASS  
**Tenable Rescan Status:** Pending

## 1. Security Risk

Windows Hello for Business uses a Trusted Platform Module (TPM) to protect authentication keys.

Hardware-backed protection helps prevent authentication keys from being extracted and reused on another computer, reducing credential theft risks.

## 2. Original Configuration

The following Group Policy setting was inspected:

Computer Configuration → Administrative Templates → Windows Components → Windows Hello for Business → Use a hardware security device

**Original setting:** Not Configured

This did not meet the DISA STIG requirement.

## 3. Remediation Performed

The policy was changed from **Not Configured** to **Enabled**.

The configuration was saved, and the following command was executed in Administrator PowerShell:

`gpupdate /force`

Windows confirmed:

`Computer Policy update has completed successfully.`

## 4. Independent Registry Verification

The following PowerShell command was executed:

`Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork" -Name RequireSecurityDevice -ErrorAction SilentlyContinue`

**Observed result:**

`RequireSecurityDevice : 1`

This confirms that the required Windows Hello for Business hardware security device policy is enabled.

## 5. Trusted Platform Module Verification

The following PowerShell command was executed:

`Get-Tpm`

**Observed results:**

| Property | Result |
|---|---|
| TpmPresent | True |
| TpmReady | True |
| TpmEnabled | True |
| TpmActivated | True |
| TpmOwned | False |
| RestartPending | False |

The system detects a TPM that is present, enabled, activated and ready.

TPM ownership was not confirmed, and Windows Hello for Business user provisioning was not independently tested.

## 6. Evidence Collected

1. Group Policy screenshot — Before remediation (Not Configured)
2. Group Policy screenshot — After remediation (Enabled)
3. PowerShell screenshot — Successful computer policy update
4. PowerShell screenshot — Registry value RequireSecurityDevice = 1
5. PowerShell screenshot — TPM verification

**Evidence status:** Screenshots captured during the lab. Separate GitHub PNG uploads pending.

## 7. Final Assessment

**Local Policy Verification: PASSED**

The required Group Policy setting was enabled and independently verified through the Windows registry.

The virtual machine also reported a ready TPM.

**Tenable Compliance Verification: PENDING RESCAN**

A subsequent authenticated Tenable compliance scan is required to confirm that the finding changes from FAILED to PASSED.

## 8. Lessons Learned

This exercise demonstrated the importance of:

- Applying Windows security baselines through Group Policy.
- Verifying security configuration independently using PowerShell.
- Understanding hardware-backed authentication protection.
- Preserving before-and-after evidence for security audits.
- Distinguishing local remediation verification from scanner-confirmed compliance.

---

**Project:** Windows 11 DISA STIG Security Hardening  
**Tooling:** Tenable Vulnerability Management, Windows Group Policy, PowerShell  
**Evidence Classification:** Practical laboratory remediation  
**STIG ID:** WN11-CC-000255
