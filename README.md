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

## Github 파일 구성요소
- nginx-youtube
  - html
  - yaml
  - Dockerfile
- nginx
  - config 파일
  - Dockerfile
- tomcat
  - config 파일
  - jsp 파일
  - Dockerfile
- yaml
  - tomcat
    - Deployment
    - Service
  - nginx
    - Deployment
    - Service
    - Configmap
  - ingress
- ajpJenkinsfile
  - Jenkins 파이프라인 코드(회원가입 페이지)
- youtubeJenkinsfile
  - Jenkins 파이프라인 코드(유튜브 영상 출력 페이지)
   
# 2. PaaS-TA 컨테이너 플랫폼 단독 배포

<details>
<summary>접기/펼치기</summary>
	
## 2-1 단독배포 아키텍쳐
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/675bb582-592e-4dff-863f-44fbd241f4e1)  

시스템 구성은 Kubernetes Cluster(Master, Worker) 환경으로 구성  
Kubespary를 통해 Kubernetes Cluster를 설치하고 Pod를 통해 Database, Private registry 등 미들웨어 환경을 제공하여 Container Image로 Kubernetes Cluster에 Container Platform 포털 환경을 배포  
총 필요한 VM 환경으로는 Master VM: 1개, Worker VM: 3개 이상이 필요하고 본 문서는 Kubernetes Cluster 환경을 구성하기 위한 Master VM 과 Worker VM 설치하며 NFS 서버를 별도로 생성하여 클러스터 구성

>컨테이너 플랫폼 v1.4 버전부터는 Cluster 배포 시 Storage가 함께 배포

>NFS 배포 시 NFS-Server 설치 선행 필요  
>[NFS 서버 설치](https://github.com/PaaS-TA/paas-ta-container-platform/blob/master/install-guide/nfs-server-install-guide.md)


## 2-2 Kubespray를 통한 kubernetes 클러스터 설치
### kubespray 란?
- kubespray 는 쿠버네티스를 쉽게 설치하는 자동화 도구  
- github을 클론받게 되면, ansible yaml파일들이 정리
- Ansible의 playbook과 inventory설정을 통해서 kubernetes 클러스터를 설정

[Kubernetes Clouster 설치가이드(PaaS-TA Github)](https://github.com/PaaS-TA/paas-ta-container-platform/blob/master/install-guide/standalone/cp-cluster-install.md)  
(위 링크 참조하여 kubespray로 쿠버네티스 클러스터 구성)

## 2-3 PaaS-TA 컨테이너 플랫폼 단독형 배포 포털 설치
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/3b62d1e6-0254-496d-a984-e36c210cf529)  
<u>음영처리된 부분 컨테이너 플랫폼 단독형 배포 포털에 포함되지 않음</u>  
- kubernetes Cluster(Master, Worker) 환경과 데이터 관리를 위한 스토리지 서버로 구성
- Kubespray를 통해 설치된 Kubernetes Cluster 환경에 컨테이너 플랫폼 포털 이미지
- Helm Chart를 관리하는 Harbor
- 컨테이너 플랫폼 포털 사용자 인증을 관리하는 Keycloak
- 인증 데이터를 관리하는 Vault
- 메타 데이터를 관리하는 MariaDB(RDBMS) 등 미들웨어 환경을 컨테이너로 제공
- 총 필요한 VM 환경으로는 Master VM: 1개, Worker VM: 3개 이상이 필요  

kubespray를 통해 kubernetest 클러스터 구성이 완료됐다면 PaaS-TA 컨테이너 플랫폼 포털 배포   
[단독형 배포 포털 설치 가이드(PaaS-TA Github)](https://github.com/PaaS-TA/paas-ta-container-platform/blob/master/install-guide/container-platform-portal/paas-ta-container-platform-portal-deployment-standalone-guide.md)  


## 2-4 컨테이너 플랫폼 포털 사용법
### 포털 메뉴
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/5e9d074f-3111-48c8-8e23-857b00e65acd)  

#### Global
- 클러스터의 전체적인 정보 및 TOP Node(CPU, Memory)를 조회  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/302b1bca-8105-4a24-8fdd-00673b1be937)  
  

#### Cluster 
- Overview - 클러스터 정보 조회 및 생성 및 생성  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/18fca64a-5ffd-4c92-bd85-bbecce082bc7)  

- Node - 클러스터의 Node 정보 조회 및 생성 및 생성   
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/47639ca0-7df3-495a-a9ab-a4f855c77727)  
 
- Namespaces - 클러스터 내 Namespace 조회 및 생성 및 생성  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/0ad1da15-0de5-496e-9a4f-a0bff7ea5378)  
  
  
#### Workloads
- Deployment - 클러스터 정보 조회 및 생성  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/c06c0ce2-0e10-43da-9793-d7c7e114b7ff)  
  
- Pods - Deployment된 pod 조회 및 생성  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/9a229eb8-fafa-4035-b246-c7d9322dd91c)

- Replicaset - Deployment된 pod의 Replicaset 조회 및 생성  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/6605a505-27d2-4e70-8426-fdbc9e5da7e3)  


#### Service
- service - service 목록 조회 및 생성  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/ed2392e3-e0bb-4b8b-85fe-7f7b56758390)  
- ingress - ingress 목록 조회 및 생성  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/fea216c1-257c-4f70-87dc-fb8507b9353e)

#### ConfigMaps
- configmaps - configmap 목록 조회 및 생성  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/3fc10b7f-3eef-4506-aa8e-0e2d4a54ae25)

#### Management 
- Users - PaaS-TA 컨테이너 플랫폼 포털 계정 정보 조회
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/fddcae5e-5698-452c-9e19-595afa39a736)
- Roles - PaaS-TA 컨테이너 플랫폼 포털 계정 역할 조회
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/9105b991-6401-454f-bbc3-7df5029525d7)

</details>

# 3.Jenkins를 사용한 파이프라인 구축
## 3-1 구축 구성도 [혜환 주임님]
## 3-2 젠킨스 설치 [혜환 주임님]
## 3-3 젠킨스 깃허브 연동(webhook/ credentials) 명노훈
## 3-4 명령어 설치(kubectl / podman) 명노훈
	
## 3-5 파이프라인 코드 작성 및 테스트 

<details>
<summary>접기/펼치기</summary>  
	
### Github 파일 구성요소
- nginx-youtube
  - html
  - yaml
  - Dockerfile
- nginx
  - config 파일
  - Dockerfile
- tomcat
  - config 파일
  - jsp 파일
  - Dockerfile
- yaml
  - tomcat
    - Deployment
    - Service
  - nginx
    - Deployment
    - Service
    - Configmap
  - ingress
- ajpJenkinsfile
  - Jenkins 파이프라인 코드(회원가입 페이지)
- youtubeJenkinsfile
  - Jenkins 파이프라인 코드(유튜브 영상 출력 페이지)

### Jenkins Pipeline 코드 작성
- Jenkins 파이프라인 생성 / Dashboard -> 새로운 item -> pipeline  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/2174a516-7e6c-4ddd-978d-61ebdb10d2e2)  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/b67a8a45-21cd-4794-ba0a-24f96491fdd6)  
- Configure 설정 / Build Trigger Github hook trigger for GITScm polling  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/b9111193-6b35-4e8f-aa19-5f3b3bfd494d)
- Jenkins Pipeline / Pipeline script from SCM 선택 -> SCM Git 선택 -> Github Repository 주소 및 Credentials 선택
- 빌드할 Github Reposiroty의 Branches 선택 
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/12325e44-f6d5-4d5a-98f7-2aaa88da83a8)
- Github Reposiroty의 파이프라인 스크립트 Path 정의
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/63d78d41-d4d4-4bdd-8772-57a2ae714b4c)

## Jenkins Pipeline Script 확인
- ajpJenkinsfile(회원가입 페이지)  
```pipeline
pipeline {
    agent any

    stages {
        stage('harbor login & podman build') {
            steps {
                sh 'sudo podman login 52.79.48.121:30002 --username admin --password Harbor12345 --tls-verify=false'
                sh 'sudo podman build -t tomcat:test -f tomcat/Dockerfile .'
                sh 'sudo podman build -t nginx:signup -f nginx/Dockerfile .'
            }
        }
		stage('podman tag & push') {
            steps {
		sh 'sudo podman tag tomcat:test 52.79.48.121:30002/ajp-repository/tomcat:harbor'
	        sh 'sudo podman push 52.79.48.121:30002/ajp-repository/tomcat:harbor --tls-verify=false'
		sh 'sudo podman tag nginx:signup 52.79.48.121:30002/ajp-repository/nginx:signup'
	        sh 'sudo podman push 52.79.48.121:30002/ajp-repository/nginx:signup --tls-verify=false'
            }
        }
		stage('deployment') {
            steps {
                sh 'kubectl apply -f yaml/ingress.yaml'
                sh 'kubectl apply -f yaml/tomcat/tomcat-service.yaml'
		sh 'kubectl apply -f yaml/tomcat/tomcat-deployment.yaml'
	        sh 'kubectl rollout restart deployment tomcat-deployment -n ajp-namespaces'

                sh 'kubectl apply -f yaml/nginx/nginx-configmap.yaml'
                sh 'kubectl apply -f yaml/nginx/nginx-service.yaml'
	        sh 'kubectl apply -f yaml/nginx/nginx-deployment.yaml'
	        sh 'kubectl rollout restart deployment hello-nginx -n ajp-namespaces'
            }
        }
    }
}
```
- youtubeJenkinsfile(유튜브 영상 출력 페이지)
```pipeline
pipeline {
    agent any

    stages {
        stage('harbor login & podman build') {
            steps {
                      sh 'sudo podman login 52.79.48.121:30002 --username admin --password Harbor12345 --tls-verify=false'
                      sh 'sudo podman build -t nginx:youtube -f nginx-youtube/Dockerfile .'
            }
        }
		stage('podman tag & push') {
            steps {
		      sh 'sudo podman tag nginx:youtube 52.79.48.121:30002/ajp-repository/nginx:youtube'
	              sh 'sudo podman push 52.79.48.121:30002/ajp-repository/nginx:youtube --tls-verify=false'
            }
        }
		stage('deployment') {
            steps {
                      sh 'kubectl apply -f nginx-youtube/yaml/youtube-nginx-service.yaml'
	              sh 'kubectl apply -f nginx-youtube/yaml/youtube-nginx-deployment.yaml'
	              sh 'kubectl rollout restart deployment youtube-nginx -n ajp-namespaces'
            }
        }
    }
}
```
- harbor login & podman build
  + Private Rsistry harbor의 로그인
  + 회원가입 각각의 nginx/tomcat Dockerfile 빌드
- podman을 사용하여 tag 및 이미지 Push
  + 각 빌드한 이미지 tag
  + 각 이미지 Push
- 회원가입 페이지 Deployment
  + Harbor에 저장한 이미지 기반으로 nginx/tomcat 배포
  + rollout 명령어를 통해 Rollingupdate

</details>


## 3-6 파이프라인 배포 확인
- 'kubectl get all -n ingress-nginx'명령어를 통해 ingress 포트확인
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/2820cd53-f02f-4fe0-935a-c9ff52149618)  
- ingress 설정에서 /path 확인 및 웹 페이지 접속 확인  
  + 회원가입 페이지  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/8fe5cc28-f91b-48e1-8a8c-4461765d0bd1)  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/3a78dfd9-7508-45bc-96e6-b12ddef3bd02)  
  + 유튜브 영상 페이지  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/1a797c1a-4961-4f92-b8af-655cd2681f44)  
![image](https://github.com/JunPyo0117/kubernetes/assets/80608601/5550f8e8-d966-4e33-849c-bf36844c86ab)

