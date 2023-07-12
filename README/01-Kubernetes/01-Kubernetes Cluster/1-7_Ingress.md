# jenkins_deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-deploy
  namespace: jenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
        - name: http-port
          containerPort: 8080
        - name: jnlp-port
          containerPort: 50000
        volumeMounts:
        - name: jenkins
          mountPath: /var/jenkins_home
      volumes:
      - name: jenkins
        persistentVolumeClaim:
          claimName: jenkins
# jenkins_service.yaml

apiVersion: v1
kind: Service
metadata:
  name: jenkins
  namespace: jenkins
spec:
  type: LoadBalancer
  ports:
    - port: 8080
      targetPort: 8080
  selector:
    app: jenkins

---

apiVersion: v1
kind: Service
metadata:
  name: jenkins-jnlp
  namespace: jenkins
spec:
  type: LoadBalancer
  ports:
    - port: 50000
      targetPort: 50000
  selector:
    app: jenkins
