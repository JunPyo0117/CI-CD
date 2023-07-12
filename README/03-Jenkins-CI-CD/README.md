# PaaS-TA Private Cloud CI/CD Pipeline Project
## 🏆 Goal
- PaaS-TA 환경에서 Privat Cloud 서비스 환경을 구축
- Jenkins를 사용하여 CI/CD 파이프라인으로 자동화 배포
  
## 💻 TEAM
- 참여자: mnh4140, JunPyo0117, hwani0w0
- 작성일: 2023.07.05~

## 🗺️ Architecture
# 3-1 구성도
![image](https://github.com/hwani0w0/devops/assets/112611582/4549e97e-a234-4e2b-ac9e-6209cc25c630)

**파이프라인 흐름**
-
1. 개발자가 소스코드를 **Commit**하여 GitHub 레포지토리에 Push 
2. GitHub **Webhook** 트리거로 Jenkins 파이프라인 Run
3. 컨테이너 이미지 **Build** 완료 후 Harbor 레포지토리로 이미지 **Push**
4. 쿠버네티스 클러스터에 WEB/WAS 서비스 배포 **Deploy**
5. WEB/WAS 서비스 정의파일(YAML)에 의해 Harbor로 부터 이미지 **Pull**
