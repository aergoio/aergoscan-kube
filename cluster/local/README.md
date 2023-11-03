# 1. 네임스페이스 생성
  ```shell
  kubectl apply -f cluster/local/namespace.yml
  ```
# 2. helm으로 Traefik 설치[Ingress Controller]
* 기본으로 깔린 `Traefik` 삭제
   ```shell
    kubectl -n kube-system delete helmcharts.helm.cattle.io traefik
    ```
* 새로운 버전의 `Traefik` 설치
  ```shell
  # helm 리포지터리 추가
  helm repo add traefik https://traefik.github.io/charts
  # helm 리포지터리에 있는 차트를 local에 최신화
  helm repo update
  # 차트 설치
  helm install traefik traefik/traefik -n kube-system
  ```
* Ingress 생성
  ```shell
    kubectl apply -f cluster/local/ingress.yml -n local
  ```
