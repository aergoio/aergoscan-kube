#!/bin/sh

. ./choice-blue-green

kubectl patch ingress aergoscan -n local --type=json -p '[{"op": "replace", "path": "/spec/rules/0/http/paths/0/backend/service/name", "value": "aergoscan-front-'$deploymentType'"}, {"op": "replace", "path": "/spec/rules/1/http/paths/0/backend/service/name", "value": "aergoscan-api-'$deploymentType'"}]'
