#!/bin/bash

helm repo add sso-charts https://bcgov.github.io/sso-helm-charts
helm repo update

helm upgrade --install sysdig-teams sso-charts/sysdig -n c6af30-tools -f values-c6af30.yaml
