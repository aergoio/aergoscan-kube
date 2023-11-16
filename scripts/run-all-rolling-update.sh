#!/bin/bash

# kubectl 명령을 실행하고 결과를 변수에 저장
result=$(kubectl get ingress aergoscan -n local -o custom-columns=SERVICE_NAME:.spec.rules[*].http.paths[*].backend.service.name --no-headers)

deploymentType="blue"
if [[ $result == *"blue"* ]]; then
    deploymentType="blue"
elif [[ $result == *"green"* ]]; then
    deploymentType="green"
else
    echo "unknown"
    exit 0
fi

echo "The current deployment type is $deploymentType."

helm upgrade --atomic --install -n local aergoscan-api-$deploymentType ../api --set-string deployment.type=$deploymentType
helm upgrade --atomic --install -n local aergoscan-front-$deploymentType ../front --set-string deployment.type=$deploymentType
