# sso-sysdig

This repository includes `Helm` charts to deploy BCGov Openshift `SysdigTeams Operators` and `Terraform` scripts to provision `Sysdig` alerts and dashboards in the following Sysdig workspaces.

- c6af30-team
- eb75ad-team

## Helm

## Terraform

Terraform runs in two places in Github Actions CI/CD pipelines.

- `pull request on main branch`: it runs `Terraform Plan` to creates an execution plan, which lets you preview the changes in the PR.
- `merge into main branch`: it runs `Terraform Apply` to apply the changes; the Terraform state is stored in a AWS S3 bucket `xgr00q-prod-sysdig`.

### Usage

In order to run the Terraform scripts locally, it requires:

- `AWS Credentials`

  1. Log into [`Cloud Pathfinder AWS LZ2 Portal`](https://oidc.gov.bc.ca/auth/realms/umafubc9/protocol/saml/clients/amazon-aws).
  1. Choose `xgr00q-prod` and `Click for Credentials`.
  1. Copy the AWS credentials and pastes into the local workspace.

- TF variable file `terraform.tfvars` with sysdig tokens.

```sh
cd terraform
cat >"terraform.tfvars" <<EOF
c6af30_team_sysdig_monitor_api_token=<sysdig_token1>
eb75ad_team_sysdig_monitor_api_token=<sysdig_token2>
EOF
terraform init
terraform apply
```
