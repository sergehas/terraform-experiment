---
name: code-review
description: Review and create Terraform changes with a focus on state safety, least privilege, module quality, drift detection, and strict plan/apply discipline.
metadata:
  version: "0.0.1"
---

# Skill: Code Review

## Overview

This skill guides agents to review and implement Terraform changes with emphasis on safety, auditability, and maintainability.

## Capability Statement

The agent will:

- Assess Terraform changes for risk, security, and operational impact
- Enforce state safety and deployment discipline
- Improve module structure and interface quality
- Require validation and rollback planning before apply

## When To Use

Use this skill when:

- Reviewing pull requests that modify Terraform
- Planning or implementing infrastructure changes
- Assessing blast radius, state risks, and security posture
- Standardizing Terraform quality checks and rollout procedures

## Example Invocation

Use prompts like:

- "Review this Terraform PR for state safety, security, and apply risk. Use the terraform-iac-reviewer skill format."
- "Assess this module change, run the Terraform validation checklist, and provide a plan summary with rollback strategy."

Expected response behavior:

- Findings first, ordered by severity with file references
- Automated check outcomes and plan risk summary
- Checklist summary by axis and explicit merge verdict

## Clarifying Questions Checklist

Before making or approving infrastructure changes, capture answers for the following:

### State Management

- Backend type (`s3`, Azure Storage, GCS, Terraform Cloud)
- State locking configuration and access
- Backup and recovery procedure
- Workspace strategy per environment

### Environment And Scope

- Target environment and change window
- Provider(s) and authentication method (OIDC preferred)
- Blast radius and downstream dependencies
- Approval and change-management requirements

### Change Context

- Change type (create, modify, delete, replace)
- Data migration or schema implications
- Rollback complexity and expected downtime

## Required Output For Every Change

### 1. Plan Summary

Include:

- Change type and scope
- Risk level
- Impact counts (add/change/destroy)

### 2. Risk Assessment

Include:

- High-risk resources and why they are risky
- Mitigations and guardrails
- Residual risk after mitigations

### 3. Validation Commands

Run and report:

```bash
terraform fmt -check
terraform validate
tflint
checkov -d .
terraform plan -out=tfplan
```

### 4. Rollback Strategy

Document one of:

- Revert code and re-apply
- Import resources and reconcile state
- Targeted destroy/recreate sequence
- State manipulation as a last resort with approvals

### 5. Produce the Review Report

Use the format in `references/report-format.md`.

## Module Design Best Practices

### Structure

- Organize files into `main.tf`, `variables.tf`, `outputs.tf`, and optionally `locals.tf`
- Provide a clear `README.md` with examples and usage constraints
- Alphabetize variables and outputs

### Variables

- Use descriptive names and descriptions
- Add type constraints and validation
- Provide sensible defaults when safe
- Prefer object types for structured inputs

### Outputs

- Expose meaningful integration points
- Add clear descriptions
- Mark sensitive outputs appropriately

## Security Best Practices

### Secrets Management

- Never hardcode credentials or tokens
- Use secrets managers (AWS Secrets Manager, Azure Key Vault, etc.)
- Generate secrets securely when needed and store externally

### IAM Least Privilege

- Avoid wildcard actions/resources unless strictly required
- Use condition keys where possible
- Regularly audit policies for excess permissions

### Encryption And Network Controls

- Encrypt data at rest and in transit by default
- Use customer-managed KMS keys where appropriate
- Block public access to storage unless explicitly required
- Prefer private networking and restricted ingress/egress

## State Management Expectations

### Backend Requirements

- Use remote state backends with encryption
- Enable locking (`dynamodb` for S3 or cloud-native locking)
- Isolate environments with workspaces or separate states

### Drift Detection

- Run scheduled `terraform plan` in CI/CD
- Alert on unexpected drift
- Investigate and reconcile drift before unrelated changes

## Policy As Code

Enforce policy gates (OPA/Sentinel or equivalent) for:

- Encryption requirements
- Tagging standards
- Network restrictions
- Least-privilege IAM constraints

Fail delivery when policy checks fail.

## Review Checklist

Use the external checklist at `references/review-checklist.md`.

Apply every item and summarize pass/issues counts by axis in the final review output.

## Plan/Apply Discipline

Use this deployment workflow:

1. `terraform fmt -check` and `terraform validate`
2. `tflint`
3. `checkov -d .`
4. `terraform plan -out=tfplan`
5. Review plan output and risk summary
6. `terraform apply tfplan` only after approval
7. Verify deployed resources and outputs

## Important Reminders

1. Always run `terraform plan` before `terraform apply`.
2. Never commit Terraform state files.
3. Keep provider and module versions pinned.
4. Never hardcode secrets.
5. Enforce least privilege for IAM.
6. Use consistent tagging across resources.
7. Validate, lint, and scan before merge.
8. Maintain a practical rollback strategy for every change.

## References

- `references/review-checklist.md`
- `references/report-format.md`
