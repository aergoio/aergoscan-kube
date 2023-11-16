#!/bin/sh

. choice-blue-green

kubectl exec -it deploy/aergoscan-es-$deploymentType -- curl http://aergoscan-api-$deploymentType.local.svc.cluster.local/v2/firstBlock
