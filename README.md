# 목차
1. Kubernetes Cluster Architecture  
&nbsp;1-1 쿠버네티스 클러스터 구성 요소  
&nbsp;&nbsp;1-1-1 Master Node(control Plane)  
&nbsp;&nbsp;&nbsp;- API Server / ETCD / Controller Manager / Scheduler  
&nbsp;&nbsp;1-1-2 Workder Node  
&nbsp;&nbsp;&nbsp;- kubelet / kube-proxy  
&nbsp;&nbsp;1-1-3 Pod  
&nbsp;&nbsp;1-1-4 ReplicaSets  
&nbsp;&nbsp;1-1-5 Deployment  
&nbsp;&nbsp;1-1-6 Service  
&nbsp;&nbsp;&nbsp;- ClusterIP / Loadbalancer / nodePort  
&nbsp;&nbsp;1-1-7 Ingress  
&nbsp;&nbsp;1-1-8 Namespaces  
&nbsp;&nbsp;1-1-9 Imperative vs Declarative  

2. PaaS-TA 컨테이너 플랫폼 단독 배포  
&nbsp;2-1 단독 배포 아키텍쳐  
&nbsp;2-2 Kubespray를 통한 클러스터 설치 법(PaaS-TA 깃허브 인용, kubespray 등 애매했던 개념들 작성)  
&nbsp;2-3 컨테이너 플랫폼 포털 사용법  


3. Jenkins를 사용한 파이프라인 구축  
&nbsp;3-1 구축 구성도   
&nbsp;3-2 젠킨스 설치  
&nbsp;3-3 젠킨스 깃허브 연동(webhook/ credentials)  
&nbsp;3-4 명령어 설치(kubectl / podman)  
&nbsp;3-5 파이프라인 코드 작성 및 테스트  
&nbsp;3-6 파이프라인 배포 확인  

   
# Kubernetes CI-CD 환경 구축
구성요소
- nginx
  - Dockerfile
  - config 파일
- tomcat
  - Dockerfile
  - config 파일
  - jsp 파일
- yaml
  - tomcat
    - Deployment
    - Service
  - nginx
    - Deployment
    - Service
    - Configmap
- ajpJenkinsfile
  - Jenkins 파이프라인 코드

![image](https://github.com/JunPyo0117/CI-CD/assets/80608601/c1bd3107-8b0d-412d-af7c-9d01d3d2b886)
