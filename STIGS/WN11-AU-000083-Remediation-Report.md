# WN11-AU-000083 — Audit Other Object Access Events

## Required configuration
Advanced Audit Policy Configuration > Object Access > Audit Other Object Access Events: **Success**.

## Initial finding
Tenable baseline reported FAILED. Initial `auditpol /get /subcategory:"Other Object Access Events"` returned `No Auditing`.

## Remediation performed
1. In Local Group Policy Editor, enabled Success auditing for Other Object Access Events.
2. Ran `gpupdate /force`, which completed successfully; effective audit policy still showed No Auditing.
3. Enabled Security Options > Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings; refreshed policy. Effective setting still showed No Auditing.
4. In elevated PowerShell ran `auditpol /set /subcategory:"Other Object Access Events" /success:enable`, which returned success.
5. Verified with `auditpol /get /subcategory:"Other Object Access Events"`: **Success**.

## Evidence
- `WN11-AU-000083-Before.png` — original provided screenshot.
- `WN11-AU-000083-Success-Selected.png` — original provided screenshot.
- `WN11-AU-000083-Verification.txt` — transcription of the user's PowerShell verification message; **not a screenshot**.

## Status
**Local verification: PASS (Success auditing effective at time of check).**
**Tenable rescan: PENDING.**
Confirm persistence after subsequent policy refresh because direct auditpol intervention was necessary.
