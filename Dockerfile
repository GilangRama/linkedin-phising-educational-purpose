FROM httpd:2.4

RUN apt-get update && \
    apt-get install -y openssl && \
    mkdir /usr/local/apache2/conf/ssl \ 
    apt-get install -y nano 

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=US/ST=Demo/L=DemoCity/O=DemoOrg/OU=IT Department/CN=localhost" \
    -keyout /usr/local/apache2/conf/ssl/server.key \
    -out /usr/local/apache2/conf/ssl/server.crt

COPY index.html /usr/local/apache2/htdocs/index.html

COPY httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf

RUN echo "Include conf/extra/httpd-ssl.conf" >> /usr/local/apache2/conf/httpd.conf

EXPOSE 80 443
