# Terraform Runbook — Unintended Database Replacement

## Purpose

This runbook describes how to respond when Terraform unexpectedly proposes to replace a database or another critical stateful resource.

The primary objective is to prevent accidental data loss and ensure infrastructure changes are reviewed before execution.

---

# 1. Stop Before Applying

If Terraform plan shows:

```text
-/+
must be replaced

do not immediately run:

terraform apply

First determine why Terraform wants to replace the resource.

A replacement of a stateful database can cause service interruption or data loss depending on the resource and configuration.

2. Review the Terraform Plan

Run:

terraform plan

Review:

Resource address
Attributes changing
Attributes marked forces replacement
Old and new values
Dependencies
Related resources that may also change

Save the plan when appropriate:

terraform plan -out=tfplan

The saved plan should be reviewed before applying it.

3. Check the Configuration Change

Determine whether the replacement is caused by an intentional configuration change.

Common causes include:

Engine changes
Engine version changes
Immutable attributes
Network configuration changes
Identifier changes
Availability configuration
Resource type changes
Incorrect variables
Incorrect environment configuration

Compare the current configuration with the previous Git commit.

4. Determine Whether the Change Is Intentional
If intentional

Confirm that:

The replacement is approved.
Backups exist.
A recovery plan exists.
Downtime has been considered.
The replacement is occurring in the correct environment.
The plan has been reviewed.

Only then should the change be applied.

If unintentional

Do not apply the plan.

Restore the intended Terraform configuration and run:

terraform plan

The expected result is:

No changes. Your infrastructure matches the configuration.
5. Protect Critical Resources

For critical resources, consider using Terraform lifecycle protection:

lifecycle {
  prevent_destroy = true
}

This can prevent Terraform from destroying a resource unintentionally.

However, prevent_destroy should not replace proper plan review and change management.

6. Verify Backups

Before intentionally replacing a database:

Confirm the latest backup exists.
Confirm the backup is usable.
Confirm retention requirements.
Confirm recovery procedures.
Confirm the maintenance window if required.

For production systems, database replacement should follow the organization's approved change-management procedure.

7. Review Dependencies

A database replacement may also affect:

Application servers
Security groups
Subnets
Route configuration
Secrets
DNS
IAM permissions
Monitoring
Backup configuration

Review the complete Terraform plan rather than only the database resource.

8. Apply a Reviewed Plan

After approval, use the saved plan:

terraform apply tfplan

Using the saved plan ensures that the reviewed plan is the plan being applied.

9. Verify After Apply

After the change:

terraform plan

The expected result is:

No changes. Your infrastructure matches the configuration.

Also verify the application and database operationally.

Check:

Connectivity
Application health
Database availability
Monitoring
Logs
Required data
Security configuration
10. If the Replacement Was Already Applied

If an unintended replacement has already occurred:

Stop further Terraform changes.
Determine whether the original resource can be recovered.
Check available backups or snapshots.
Follow the approved recovery procedure.
Avoid additional uncontrolled Terraform changes.
Document the incident and root cause.
Correct the Terraform configuration.
Run a new plan before continuing.

Do not perform repeated applies without understanding the resulting state.

11. Prevention

The following practices reduce the risk of accidental replacement:

Always run terraform plan before apply.
Review forces replacement changes carefully.
Use pull requests for infrastructure changes.
Keep Terraform state remote and locked.
Use separate state for different environments.
Protect critical resources with appropriate lifecycle rules.
Maintain reliable backups.
Use saved Terraform plans for controlled deployments.
Run validation and formatting checks in CI.
Perform periodic drift detection.
Quick Response Checklist
[ ] Stop Terraform apply
[ ] Review terraform plan
[ ] Identify the attribute forcing replacement
[ ] Check recent configuration changes
[ ] Determine whether replacement is intentional
[ ] Check backups
[ ] Review dependencies
[ ] Confirm correct environment
[ ] Obtain approval for destructive changes
[ ] Save and review the Terraform plan
[ ] Apply only the reviewed plan
[ ] Verify infrastructure after apply
[ ] Run terraform plan again
[ ] Confirm no unexpected changes remain
Emergency Principle

Never approve a destructive Terraform plan simply because the command is expected to succeed.

The important question is whether the proposed infrastructure change is intentional, understood, recoverable and approved.