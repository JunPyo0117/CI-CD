20230705 작성 시작
쿠버네티스(PaaS-TA) + 젠킨스 활용한 CICD 구현 프로젝트

- 클러스터란
  - 컨테이너화된 애플리케이션을 실행하는 노드의 집합
  - 모든 클러스터는 최소 1개의 워커 노드를 가진다


 
----------------------------------------

- 클러스터란
  - 컨테이너화된 애플리케이션을 실행하는 노드의 집합
  - 모든 클러스터는 최소 1개의 워커 노드를 가진다
- 클러스터 아키텍처
![image](https://github.com/JunPyo0117/CI-CD/assets/71053769/ebe3d9f7-7fff-4695-b952-533cfee44d38)

## 쿠버네티스 클러스터 구성요소

> ### Master node(control Plane)
- 역할
  - 워커 노드와 클러스터 내 파드를 관리
- 구성 요소   
   - api server
  - ETCD
  - controller manager
  - Scheduler
  
> ### Worker node
- 역할
  - 애플리케이션의 구성요소인 파드를 호스트한다
- 구성 요소   
  - kublet
  - k-proxy

----------------------------

  1-1-2 Workder Node
   - kubelet / kube-proxy
  1-1-3 Pod
  1-1-4 ReplicaSets
  1-1-5 Deployment
  1-1-6 Service
   - ClusterIP / Loadbalancer / nodePort
  1-1-7 Ingress
  1-1-8 Namespaces
  1-1-9 Imperative vs Declarative
