#!/bin/sh

. ./choice-blue-green

helm uninstall -n local aergoscan-front-$deploymentType
helm uninstall -n local aergoscan-api-$deploymentType
helm uninstall -n local aergoscan-indexer-$deploymentType
helm uninstall -n local aergoscan-es-$deploymentType

