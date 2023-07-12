## Namespaces
- 오브젝트를 묶는 하나의 가상공간 또는 그룹
- 네임스페이스를 통해 CPU/GPU 할당량 조절할 수 있음
  
+ `dev`환경과 `prod`환경을 구별할 수 있음
```bash
kubectl get namespaces
 
kubectl get pods --namespace=dev
kubectl create pod-definition.yml --namespace=dev  # 혹은 yaml파일에 추가
```

```bash
kubectl create namespace dev

kubectl config set-context $(kubectl config current-context) --namespcae=dev  # default 네임스페이스 변경
kubectl get pods

kubectl get pods --all-namepasces
```

```bash
kubectl run redis --image=redis --namespace=finance
```

## DNS
+ DNS는 다음과 같은 형태 `db-service.dev.svc.cluster.local` 
+ 차례로 `<Service Name>.<Namespace>.<Service>.<Domain>` 조합으로 구성
+ 서비스가 생성될 때 DNS 항목이 자동으로 추가


## Resource Quota
+ Namepace 리소스 제한
+ 리소스에 용량 할당
```bash
kubectl create -f compute-quota.yaml
```
```yaml
apiVersion: v1
kind: ResourceQuota
meatadata:
  name: compute-quota
  namespace: dev
spec:
  hard:
    pods: "10"
    requests.cpu: "4"
    requests.memory: 5Gi
    limits.cpu: "10"
    limits.memory: 10Gi
```
