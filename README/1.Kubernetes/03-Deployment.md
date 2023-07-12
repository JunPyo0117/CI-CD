## Deployment

`kind : Deployment` 제외하고, **Replicasets** 정의와 yaml 동일 

```bash
kubectl create -f deployment definition.yml
kubectl get deployments
```


## Tips!

생성 모든 객체 한번에 보기
```bash
kubectl get all
```

yaml 파일 생성어려울 때는..
```bash
kubectl run 
```

예시
```bash
# pod 생성
kubectl run nginx --image=nginx
# pod yaml 보기 not create
kubectl run nginx --image=nginx --dry-run=client -o yaml
# deployment 생성
kubectl create deployment --image=nginx nginx
# deployment yaml 보기 not create
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
# deployment yaml 파일 생성
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml

# deployment with 4 replicas
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml
```
