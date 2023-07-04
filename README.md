# 목차
1.Kubernetes Cluster Architecture  
  1-1 쿠버네티스 클러스터 구성 요소  
       1-1-1 Master Node(control Plane)  
             - API Server / ETCD / Controller Manager / Scheduler  
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

2. PaaS-TA 컨테이너 플랫폼 단독 배포
   2-1 단독 배포 아키텍쳐
   2-2 Kubespray를 통한 클러스터 설치 법(PaaS-TA 깃허브 인용, kubespray 등 애매했던 개념들 작성)
   2-3 컨테이너 플랫폼 포털 사용법

3. Jenkins를 사용한 파이프라인 구축
   3-1 구축 구성도 
   3-2 젠킨스 설치
   3-3 젠킨스 깃허브 연동(webhook/ credentials)
   3-4 명령어 설치(kubectl / podman)
   3-5 파이프라인 코드 작성 및 테스트
   3-6 파이프라인 배포 확인

   
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
