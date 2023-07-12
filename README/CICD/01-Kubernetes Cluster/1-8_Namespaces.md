# 1-8 Namespaces
## 1-8-1 역할
- 오브젝트를 묶는 하나의 가상공간 또는 그룹
- 예시 `dev`환경과 `prod`환경을 구별할 수 있음
- 네임스페이스를 통해 CPU/GPU 할당량 조절할 수 있음
   
## 1-8-2 사용
- 네임스페이스 조회
```bash
kubectl get namespaces
 
kubectl get pods --namespace=dev
kubectl get pods --all-namepasces
```
   
- 네임스페이스 생성 및 변경
```bash
kubectl create namespace dev
   
# default 네임스페이스 변경
kubectl config set-context $(kubectl config current-context) --namespcae=dev  
kubectl get pods
```

- 네임스페이스 활용
```bash
kubectl run redis --image=redis --namespace=finance
kubectl create pod-definition.yml --namespace=dev  # 혹은 yaml파일에 추가
```
