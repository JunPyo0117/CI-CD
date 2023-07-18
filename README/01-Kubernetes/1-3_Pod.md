# 1-3 Pod
## 1-3-1 정의
![image](https://github.com/JunPyo0117/CI-CD/assets/71053769/ee228ed5-b78a-4421-9082-3dd9c653dcc7)
- 하나 이상의 컨테이너 그룹
- 그룹은 자원(스토리지 및 네트워크)을 공유함
- 쿠버네티스에서 생성/관리/배포 가능한 가장 작은 컴퓨팅 단위

## 1-3-2 사용
- pod 목록 호출
```bash
kubectl get pods
```
   
- pod 정보
```bash
kubectl describe pod myapp-pod
```

- pod 생성(명령형)
```bash
kubectl run redis --image-redis --dry-run -o yaml
kubectl run test --image=redis --dry-run=client -o yaml
kubectl run test --image=redis --dry-run=client -o yaml > test.yaml
```
  
- pod 생성(선언형)
  - pod 생성 `create`  `apply` 둘다 가능
```bash
kubectl apply -f pod.yaml
```



- pod yaml 예시
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
