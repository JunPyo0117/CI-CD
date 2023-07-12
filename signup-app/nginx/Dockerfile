FROM nginx

RUN mkdir -p /usr/share/nginx/html/signup
RUN cp /usr/share/nginx/html/index.html /usr/share/nginx/html/signup
#COPY index.html /usr/share/nginx/html/signup

# Reverse Proxy config 파일 복사
COPY signup-app/nginx/config/default.conf /etc/nginx/conf.d/default.conf

