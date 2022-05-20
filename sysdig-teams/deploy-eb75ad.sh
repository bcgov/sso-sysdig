#!/bin/bash

helm repo add sso-charts https://bcgov.github.io/sso-helm-charts
helm repo update

helm upgrade --install sysdig-teams sso-charts/sysdig -n eb75ad-tools -f values-eb75ad.yaml
