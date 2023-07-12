# 1-6 Service
## 1-6-1 역할
- 파드 집합에서 실행중인 애플리케이션을 네트워크 서비스로 노출
- **노드-노드** 혹은 **노드-사용자** 통신을 위한 가상 컴포넌트
- 파드는 삭제/생성 시 마다 IP가 유동적으로 변함
- 서비스는 애플리케이션이 외부와 통신하기 위해 **단일 진입점(Single Interface)** 을 부여함
- Endpoints는 `PodIP:APPort`
   
## 1-6-2 NodePort
- `NodeIP:NodePort` 요청을 연결된 Pod로 트래픽 전달
- 로드밸런서 기능
- **ClusterIP** 자동생성
```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  type: NodePort
  ports:
  - targetPort: 80  # 애플리케이션 포트
    port: 80  # 서비스 포트
    nodePort: 30008  # 외부 사용자가 애플리케이션에 접근하기 위한 포트(optional)
  selector:  # 서비스와 연결되는 파드
    app: myapp
    type: frontend
```
 
## 1-6-3 Cluster IP
- `PodIP:ApplicationPort`를 `NodeIP:NodePort`로 넘겨줌
- 여기서 파드는 클러스터(혹은 그룹화) 형태
```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  type: ClusterIP  # optional
  ports:
  - protocol: TCP
    targetPort: 9376  # 애플리케이션 포트
    port: 80  # 서비스 포트
  selector:  # 서비스와 연결되는 파드(optional)
    app: myapp
    type: frontend
```
 
## 1-6-4 LoadBalancer
* CSP(GCP, AWS, Azure ...) 환경에서 제공하는 로드밸런서-쿠버네티스 클러스터(파드그룹)
* **NodePort** 동일하게 동작
 
 
## 1-6-5 사용
- 확인 및 생성
```bash
kubectl get service
kubectl get svc
 
kubectl describe svc kubernetes
 
kubectl create -f service-definition.yaml
```
   
- **service-definition.yaml** 예제
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: webapp-service 
  namespace: default
spec:
  ports:
  - nodePort: 30080
    port: 8080
    targetPort: 8080
  selector:
    name: simple-webapp
  type: NodePort
 ```
 
