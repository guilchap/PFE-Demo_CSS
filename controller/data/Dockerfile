FROM debian:bullseye

RUN apt update
RUN apt -y upgrade
RUN apt-get install -y apache2
RUN apt-get install -y php libapache2-mod-php php-mysql php-intl php-curl php-xmlrpc php-soap php-gd php-json php-cli php-pear php-xsl php-zip php-mbstring
RUN apt-get install -y wget gnupg unzip curl nano
RUN apt-get install -y systemctl net-tools

#RUN systemctl start apache2
RUN systemctl enable apache2

RUN adduser --disabled-password --no-create-home etudiant
RUN echo etudiant:network | chpasswd
RUN echo root:network | chpasswd

EXPOSE 80

EXPOSE 22

#CMD ["apache2","-D","FOREGROUND"]