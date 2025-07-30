FROM httpd:2.4

RUN apt-get update && \
    apt-get install -y openssl nano && \
    mkdir /usr/local/apache2/conf/ssl

RUN mkdir -p /usr/local/apache2/conf/ssl

COPY docker/ssl-conf/openssl.cnf /tmp/openssl-san.cnf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /usr/local/apache2/conf/ssl/server.key \
    -out /usr/local/apache2/conf/ssl/server.crt \
    -config /tmp/openssl-san.cnf \
    -extensions v3_req

COPY index.html /usr/local/apache2/htdocs/index.html

COPY docker/apache2/conf/httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf

RUN echo "Include conf/extra/httpd-ssl.conf" >> /usr/local/apache2/conf/httpd.conf

EXPOSE 80 443