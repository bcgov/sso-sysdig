#!/bin/bash

helm repo add sso-charts https://bcgov.github.io/sso-helm-charts
helm repo update

helm upgrade --install sysdig-teams sso-charts/sysdig -n e4ca1d-tools -f values-e4ca1d.yaml
