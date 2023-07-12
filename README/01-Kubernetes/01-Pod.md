## Pod
## 정의
- 하나 이상의 컨테이너 그룹
- 그룹은 자원(스토리지 및 네트워크)을 공유함
- 쿠버네티스에서 생성/관리/배포 가능한 가장 작은 컴퓨팅 단위
  
pod 생성 `create`  `apply` 둘다 가능
```bash
kubectl apply -f pod.yaml
```

pod 목록 호출
```bash
kubectl get pods
```

pod 정보
```bash
kubectl describe pod myapp-pod
```

pod 생성 후 yaml 파일 저장
```bash
kubectl run redis --image-redis --dry-run -o yaml
kubectl run test --image=redis --dry-run=client -o yaml
kubectl run test --image=redis --dry-run=client -o yaml > test.yaml
```

pod yaml 예시
```yaml
apiVersion : v1
kind : Pod
metatdata :
  name : nginx
  labels :
    app : nginx
    tier : frontend
spec :
  containers :
  - name : nginx
    image : nginx
  - name : busybox
    image : busybox
```
