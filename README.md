# Secure Azure App Starter

A DevSecOps-ready Azure infrastructure template with automated security scanning and CI/CD deployment. It is a CI/CD gate that runs Checkov and Trivy on every push, blocking commits with policy violations, exposed secrets, or known CVEs before they reach the infrastructure.

## What problem am I solving?
Azure environments often accumulate unvalidated Terraform configs and unscanned secrets that slip through manual reviews. These gaps become attack surfaces before anyone notices.

## Why does it matter?
Catching misconfigurations at commit time prevents the kind of drift that leads to real breaches. One blocked commit today is one less incident response tomorrow.

## What's Deployed

- Azure VNet with isolated subnet (northeurope)
- Network Security Group enforcing HTTPS-only inbound traffic
- GitHub Actions pipeline with Checkov + Trivy security scanning on every push/PR
- Automated Terraform deploy workflow using service principal authentication

## Tech Stack

- Terraform (IaC)
- GitHub Actions (CI/CD)
- Checkov (Terraform policy scanning)
- Trivy (misconfiguration detection)
- Azure (VNet, NSG, Subnet)

## How It Works

1. Push to main triggers security scans (Checkov + Trivy)
2. If scans pass, Terraform plan + apply deploys infra to Azure
3. NSG enforces least-privilege network access by default

## Architecture


Push to main
     │
     ▼
┌─────────────────┐
│  GitHub Actions │
├─────────────────┤
│ Checkov + Trivy │ ──► Blocks policy violations,
│  Security Scan  │     exposed secrets, CVEs
└────────┬────────┘
         │ Pass
         ▼
┌─────────────────┐
│   Terraform     │
│  Plan + Apply   │
└────────┬────────┘
         │
         ▼
┌─────────────────────────┐
│      Azure (northeurope)│
│  ┌───────────────────┐  │
│  │   VNet 10.0.0.0/16│  │
│  │  ┌─────────────┐  │  │
│  │  │ Subnet      │  │  │
│  │  │ 10.0.1.0/24 │  │  │
│  │  └──────┬──────┘  │  │
│  │         │         │  │
│  │    ┌────▼────┐    │  │
│  │    │   NSG   │    │  │
│  │    │ :443 ✅ │    │  │
│  │    │  All ❌ │    │  │
│  │    └─────────┘    │  │
│  └───────────────────┘  │
└─────────────────────────┘

## Getting Started

1. Clone this repo
2. Configure Azure service principal as GitHub secrets (ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID)
3. Push to main and watch the pipeline deploy