FROM debian:bullseye

RUN apt update
RUN apt -y upgrade
RUN apt-get install -y \
    nano \
    systemctl \
    net-tools \
    supervisor \
    openssh-server \
    apache2 \
    php libapache2-mod-php php-mysql php-intl php-curl \
    php-xmlrpc php-soap php-gd php-json php-cli php-pear \
    php-xsl php-zip php-mbstring

RUN adduser --disabled-password --no-create-home etudiant
RUN echo etudiant:network | chpasswd
RUN echo root:network | chpasswd

RUN mkdir /run/sshd

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY site_web_docker/index.html /home/etudiant/site_web_docker/
COPY site_web_docker/index.css /home/etudiant/site_web_docker/
COPY site_web_docker/html.png /var/www/html/
COPY site_web_docker/linux.png /var/www/html


RUN mkdir -p /var/log/supervisor
RUN echo 'Port 22\nPermitRootLogin yes\n' >> /etc/ssh/sshd_config \
 && mkdir -p /var/run/sshd
RUN chown -R www-data:www-data /var/www/html \
 && mkdir -p /var/lock/apache2 /var/run/apache2

EXPOSE 22 80

CMD ["/usr/bin/supervisord"]

#docker build --no-cache -t NOM .
#docker run -d -p 8082:80 -p 6056:22 NOM