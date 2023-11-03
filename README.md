# 공통
* `helm` 차트 배포 시 `local` 일 경우는 `install`, `upgrade` 명령 그대로 사용한다.
* `local` 이 아닌, `testnet`, `mainnet` 일 경우 차트의 `values.yaml` 파일을 `values-testnet.yaml`, `values-mainnet` 으로 변경해야 한다.
* ex) 
    ``` shell
    helm upgrade --atomic --install -f ~/aergoscan-kube/elasticsearch/values-testnet.yaml  aergoscan-es ./elasticsearch
    ```

# 클러스터 설정
* [local README.md](cluster/local/README.md)

# elasticsearch 배포
* [README.md](elasticsearch/README.md)
