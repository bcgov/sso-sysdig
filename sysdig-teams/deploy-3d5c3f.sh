#!/bin/bash

helm repo add sso-charts https://bcgov.github.io/sso-helm-charts
helm repo update

helm upgrade --install sysdig-teams sso-charts/sysdig -n 3d5c3f-tools -f values-3d5c3f.yaml
