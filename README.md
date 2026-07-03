# Secure-Azure-App-Starter
## What problem am I solving?
Azure environments often accumulate unvalidated Terraform configs and unscanned secrets that slip through manual reviews. These gaps become attack surfaces before anyone notices.

## What did I build?
A CI/CD gate that runs Checkov and Trivy on every push, blocking commits with policy violations, exposed secrets, or known CVEs before they reach the infrastructure.

## Why does it matter?
Catching misconfigurations at commit time prevents the kind of drift that leads to real breaches. One blocked commit today is one less incident response tomorrow.
