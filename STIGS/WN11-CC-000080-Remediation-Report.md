# Windows 11 STIG Remediation Report — WN11-CC-000080

**Project:** Windows 11 Security Technical Implementation Guide (STIG) Remediation Lab  
**STIG ID:** WN11-CC-000080  
**Vulnerability ID:** V-253371  
**Rule ID:** SV-253371r1210291_rule  
**Severity:** CAT II (Medium)  
**Audit benchmark:** DISA_STIG_Microsoft_Windows_11_v2r9.audit  
**Assessment tool:** Tenable  
**Status:** Locally verified — final Tenable rescan pending

## 1. Security Finding

The baseline Tenable assessment reported WN11-CC-000080 as FAILED.

The control requires virtualization-based protection of code integrity to be enabled, strengthening Windows against unauthorized kernel-mode code execution.

## 2. Initial Configuration

Before remediation:

- Turn On Virtualization Based Security: Not Configured
- Virtualization Based Protection of Code Integrity: Disabled
- VirtualizationBasedSecurityStatus: 0
- SecurityServicesConfigured: {0}
- SecurityServicesRunning: {0}

This established that the required protection was not running.

## 3. Prerequisite Verification

The following prerequisites were examined:

- Secure Boot: Confirmed enabled (`True`)
- Available security properties: 1, 2, 3, 5, 7
- Virtualization and hardware security capabilities were reported by Windows.

## 4. Remediation Performed

Opened Local Group Policy Editor and navigated to:

`Computer Configuration → Administrative Templates → System → Device Guard → Turn On Virtualization Based Security`

Configured:

- Turn On Virtualization Based Security: Enabled
- Select Platform Security Level: Secure Boot
- Virtualization Based Protection of Code Integrity: Enabled without lock

The without-lock option was selected for easier recovery within the virtual machine lab.

## 5. Policy Application

Executed:

`gpupdate /force`

Windows reported successful completion of both Computer Policy and User Policy updates.

## 6. Registry Verification

Inspected:

`HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard`

Observed:

- `EnableVirtualizationBasedSecurity = 1`
- `RequirePlatformSecurityFeatures = 1`
- `HypervisorEnforcedCodeIntegrity = 2`
- `HVCIMATRequired = 0`

These values were consistent with the selected Group Policy configuration.

## 7. Restart and Runtime Verification

Restarted the virtual machine using:

`Restart-Computer`

After reconnecting, executed:

```powershell
Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard |
Select-Object VirtualizationBasedSecurityStatus, SecurityServicesConfigured, SecurityServicesRunning
```

Observed:

```text
VirtualizationBasedSecurityStatus : 2
SecurityServicesConfigured       : {2}
SecurityServicesRunning          : {2}
```

Interpretation:

- Virtualization-based security is running.
- Hypervisor-protected code integrity is configured.
- Hypervisor-protected code integrity is actively running.

## 8. Evidence Files

| File | Purpose |
|---|---|
| WN11-CC-000080-Before.png | Original Group Policy configuration |
| WN11-CC-000080-Enabled.png | Corrected Group Policy settings |
| WN11-CC-000080-Policy-Refresh.png | Successful policy application |
| WN11-CC-000080-Registry-Verified.png | Registry configuration evidence |
| WN11-CC-000080-HVCI-Running.png | Post-restart runtime verification |

## 9. Validation Result

**Local technical validation: PASS**

The Windows runtime evidence confirms that VBS and HVCI are running following remediation and restart.

**Tenable compliance status: PENDING RESCAN**

The original Tenable finding must not be reported as scanner-confirmed PASS until an authenticated rescan validates the control.

## 10. Final Assessment

The remediation was implemented successfully and independently verified using Group Policy, registry inspection, and Windows runtime security information.

The final authenticated Tenable scan will determine whether the finding is formally cleared in the assessment tool.

**Evidence classification:** Authorized cyber-range lab exercise.  
**GitHub destination:** Private repository, `STIGS` directory.
