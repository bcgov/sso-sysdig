# Generating service accounts for the CICD pipeline

The github actions need service accounts to run. The script `generate_sa.sh` will create a service acount for the tool environment of a given openshift project and give that account the roles tools.

## Generate the service accounts

While logged into the **Gold** instance run:

`
./generate_sa.sh e4ca1d gold
`
To generate the token run

`
oc -n e4ca1d-tools apply -f token-secret.yaml
`
in the templates folder

## Update the github action secrets

The github actions require one token to deploy resources in Gold.

Each service account will generate a secret in the `-tools` namespace with the name `sysdig-terraform-deployer-e4ca1d-token`.  Copy this token into the GithHub secrets on this repo.

OPENSHIFT_TOKEN_GOLD
