FROM nginx

# 디렉터리 생성
RUN mkdir -p /usr/share/nginx/html/youtube

# 
#COPY index.html /usr/share/nginx/html
#COPY index.html /usr/share/nginx/html/youtube

# 유튜브 영상 출력 html 파일 복사
COPY youtube-app/html/index.html /usr/share/nginx/html/youtube/index.html
