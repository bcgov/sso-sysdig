# sso-sysdig

![Lifecycle:Stable](https://img.shields.io/badge/Lifecycle-Stable-97ca00)

This repository includes `Helm` charts to deploy the `sysdig-team custom resource` for the BCGov Openshift `Sysdig Team Operator` and `Terraform` scripts to provision `Sysdig` alerts and dashboards in the following Sysdig workspaces.

- c6af30-team
- eb75ad-team

## Purpose

`Terraform` automates the infrastructure/configuration management using a declarative configuration language, and provides benefits such as `peer review`, `version control`,`security as code`, `policy enforcement`, and `reduced provisioning time`.

Please see [Using Terraform for container security as code with Sysdig Secure](https://sysdig.com/blog/using-terraform-for-container-security-as-code/).

## Helm

The Helm chart defines the `Sysdig Team Members` in `c6af30` and `eb75ad` projects in the Gold cluster. Helm runs in the following GitHub event on Github Actions CI/CD pipelines:

- `merge into main branch`: it runs `Helm upgrade` to release a new version of the chart and apply the changes made.
- see [Helm GitHub Actions](.github/workflows/sysdig-teams.yml)
- you can either use the same sysdig helm chart or create your own leveraging the [sysdig helm chart definition](https://github.com/bcgov/sso-helm-charts/tree/main/charts/sysdig)

## Terraform

The Terraform script defines the `alerts` and `dashboard` configuration of the `Sysdig Workspaces` in `c6af30` and `eb75ad` projects in the Gold cluster. Terraform runs in the following two GitHub events on Github Actions CI/CD pipelines:

- `pull request on main branch`: it runs `Terraform Plan` to creates an execution plan, which lets you preview the changes in the PR.
- `merge into main branch`: it runs `Terraform Apply` to apply the changes; the Terraform state is stored in a AWS S3 bucket `xgr00q-prod-sysdig`.
- see [Terraform GitHub Actions](.github/workflows/terraform.yml)

### Usage

In order to run the Terraform scripts locally, it requires:

- `AWS Credentials`

  1. Log into [`Cloud Pathfinder AWS LZ2 Portal`](https://oidc.gov.bc.ca/auth/realms/umafubc9/protocol/saml/clients/amazon-aws).
  1. Choose `xgr00q-prod` and `Click for Credentials`.
  1. Copy the AWS credentials and pastes into the local workspace.

- TF variable file `terraform.tfvars` with sysdig tokens.

Note: the Sysdig api tokens must be those of the sysdig team, not a sysdig user's personal credentials.  These are stored with other team secrets.  Using the wrong credentials will cause unpredictable behaviour when terraform attempts to generate dashboards and alerts.

```sh
cd terraform
cat >"terraform.tfvars" <<EOF
gold_c6af30_team_sysdig_monitor_api_token=<sysdig_token1>
gold_eb75ad_team_sysdig_monitor_api_token=<sysdig_token2>
EOF
terraform init
terraform apply
```
