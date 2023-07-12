# 1-4 Replicasets
## 1-4-1 기능
- 명시된 파드 가용성 보증
- 복제 파드 집합의 실행을 항상 안정적으로 유지
  
## 1-4-2 사용
- replicasets 생성 `create`  `replace` 둘다 가능
```bash
kubectl create -f replicaset.yaml
```

- replicasets 정보
```bash
kubectl get replicaset
kubectl get rs

kubectl delete rs replicaset-1
```

- replicasets yaml 작성 가이드
```bash
kubectl explain replicaset 
```

- replica yaml 예시
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset
spec:
  replicas: 3
  selector:
    matchLabels: 
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx-container
        image: nginx
```

- replicasets 수정
```bash
kubectl edit rs new-replica-set
kubectl describe rs
kubectl delete pod new-replica-set-123 # 삭제하면 변경된 replicaset 적용된 pod 자동 실행
```

- Scale 변경
```bash
kubectl scale rs new-replica-set --replicas=5
```
