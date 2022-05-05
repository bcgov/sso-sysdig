# sso-sysdig

This repository includes `Helm` charts to deploy BCGov Openshift `SysdigTeams Operators` and `Terraform` scripts to provision `Sysdig` alerts and dashboards in the following Sysdig workspaces.

- c6af30-team
- c6af30-team-persistent-storage
- eb75ad-team
- eb75ad-team-persistent-storage

## Helm

## Terraform

Terraform runs in CD pipeline on the push event to the `main` branch, and applies the changes; the Terraform state is stored in the `Terraform Cloud workspace` created for this repository.

### Usage

In order to run the Terraform scripts locally for testing purposes, create a variable file `terraform.tfvars` and set sysdig tokens accordingly.

```sh
cd terraform
cat >"terraform.tfvars" <<EOF
c6af30_team_sysdig_monitor_api_token=<sysdig_token1>
c6af30_pv_sysdig_monitor_api_token=<sysdig_token2>
EOF
terraform init
terraform apply
```
