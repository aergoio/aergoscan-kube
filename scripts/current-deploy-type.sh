#!/bin/bash

# kubectl 명령을 실행하고 결과를 변수에 저장
result=$(kubectl get ingress aergoscan -n local -o custom-columns=SERVICE_NAME:.spec.rules[*].http.paths[*].backend.service.name --no-headers)

# 결과가 "blue"를 포함하면 "blue" 출력, "green"을 포함하면 "green" 출력, 둘 다 없으면 "unknown" 출력
if [[ $result == *"blue"* ]]; then
    echo "blue"
elif [[ $result == *"green"* ]]; then
    echo "green"
else
    echo "unknown"
fi

