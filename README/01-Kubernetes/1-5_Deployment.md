# 1-5 Deployment
## 1-5-1 기능
- 파드와 레플리카셋(ReplicaSet)에 대한 선언적 업데이트를 제공

## 1-5-2 사용
- `kind : Deployment` 제외하고, **Replicasets** 정의와 yaml 동일 
- 확인
```bash
kubectl create -f deployment definition.yml
kubectl get deployments
```
- 생성
```bash
# deployment 생성
kubectl create deployment --image=nginx nginx
  
# deployment yaml 보기 not create
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
  
# deployment yaml 파일 생성
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml

# deployment with 4 replicas
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml
```
