#!/bin/bash

helm repo add sso-charts https://bcgov.github.io/sso-helm-charts
helm repo update

helm upgrade --install sysdig-teams sso-charts/sysdig -n b29129-tools -f values-b29129.yaml
