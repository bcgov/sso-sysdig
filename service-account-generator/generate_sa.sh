#!/bin/bash
set -e

usage() {
    cat <<EOF
Creates a service account for the tools environments of the project with
namespace licence plate arg.

Usages:
    $0 <project_licence_plate> <cluster>

Available licence plates:
    - e4ca1d
    - eb75ad

Available Clusters
    - gold

Examples:
    $ $0 e4ca1d gold
EOF
}

if [ "$#" -lt 2 ]; then
    usage
    exit 1
fi

licence_plate=$1
cluster=$2

# # create service account in tools
oc -n "$licence_plate"-tools create sa sysdig-terraform-deployer-"$licence_plate"



create_role_and_binding() {
  if [ "$#" -lt 3 ]; then exit 1; fi
  licence_plate=$1
  env=$2
  cluster=$3
  namespace="$licence_plate-$env"

  oc process -f ./templates/role-"$cluster".yaml -p NAMESPACE="$namespace" | oc -n "$namespace" apply -f -

  oc -n "$namespace" create rolebinding sysdig-terraform-deployer-role-binding-"$namespace"   \
  --role=sysdig-terraform-deployer-"$namespace" \
  --serviceaccount="$licence_plate"-tools:sysdig-terraform-deployer-"$licence_plate"
}

create_team_role_and_binding() {
  if [ "$#" -lt 2 ]; then exit 1; fi
  licence_plate=$1
  env=$2
  namespace="$licence_plate-$env"

  oc process -f ./templates/role-team-creation.yaml -p NAMESPACE="$namespace" | oc -n "$namespace" apply -f -

  oc -n "$namespace" create rolebinding sysdig-team-creator-role-binding-"$namespace"   \
  --role=sysdig-team-creator-"$namespace" \
  --serviceaccount=e4ca1d-tools:sysdig-terraform-deployer-"$licence_plate"
}

# # for tools create the role and role binding
create_role_and_binding "$licence_plate" "tools" "$cluster"

create_team_role_and_binding "b29129" "tools"
create_team_role_and_binding "c6af30" "tools"
create_team_role_and_binding "eb75ad" "tools"
