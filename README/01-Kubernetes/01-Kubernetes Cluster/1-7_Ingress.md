# 1-7 Ingress
## 1-7-1 역할
![img1 daumcdn](https://github.com/hwani0w0/devops/assets/112611582/b48cbac1-f9e1-4095-9233-fbb186352e3c)

- **Ingress**
  - 클러스터 내의 서비스에 대한 외부 접근을 관리하는 API 오브젝트
  - HTTP(S) 기반의 L7 로드밸런싱 기능을 제공하는 컴포넌트
  - 쿠버네티스에서 실행중인 Deployment와 Service에 접근하기 위한 관문과 같은 역할을 담당
   
- **Ingress Controller**
  - 인그레스의 규칙을 실제로 동작하게 함.
  - 직접 Ingress Controller를 구동하려면 Nginx 웹 서버 기반의 Nginx Ingress Controller를 사용할 수 있겠고,
  - 클라우드 플랫폼에 위임하려면 GKE (Google Kubernetes Engine) 의 기능을 사용할 수도 있다.

## 1-7-2 사용
- **ingress.yaml** 예시
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: path-ingress
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /blue
        pathType: Prefix
        backend:
          service:
            name: blue
            port:
              number: 80
      - path: /green
        pathType: Prefix
        backend:
          service:
            name: green
            port:
              number: 80
```
