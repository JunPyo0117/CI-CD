## 3-5 파이프라인 코드 작성 및 테스트 
## Github 파일 구성요소
- youtube-app
  + html
  + yaml
  + Dockerfile
- signup-app
  + nginx
    * config 파일
    * Dockerfile
  + tomcat
    * config 파일
    * jsp 파일
    * Dockerfile
  + yaml
    * tomcat
      - Deployment
      - Service
    * nginx
      - Deployment
      - Service
      - Configmap
    * ingress
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
