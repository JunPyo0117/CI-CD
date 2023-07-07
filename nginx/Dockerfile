FROM nginx

RUN mkdir -p /usr/share/nginx/html/signup
COPY /usr/share/nginx/html/index.html /usr/share/nginx/html/signup/index.html 
COPY index.html /usr/share/nginx/html/signup

# Reverse Proxy config 파일 복사
COPY nginx/config/default.conf /etc/nginx/conf.d/default.conf

