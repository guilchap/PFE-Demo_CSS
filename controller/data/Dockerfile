FROM debian:bullseye

RUN apt update
RUN apt -y upgrade
RUN apt-get install -y apache2
RUN apt-get install -y php libapache2-mod-php php-mysql php-intl php-curl php-xmlrpc php-soap php-gd php-json php-cli php-pear php-xsl php-zip php-mbstring
RUN apt-get install -y wget gnupg unzip curl nano
RUN apt-get install -y systemctl net-tools openssh-server

RUN adduser --disabled-password --no-create-home etudiant
RUN echo etudiant:network | chpasswd
RUN echo root:network | chpasswd

RUN mkdir /run/sshd

#COPY script_demarrage.sh .

EXPOSE 80

EXPOSE 22

CMD /usr/sbin/sshd -D
#CMD /usr/sbin/sshd -D && apache2ctl -D FOREGROUND
#ENTRYPOINT ./script_demarrage.sh

#docker build --no-cache -t NOM .
#docker run -d -p 8082:80 -p 6056:22 NOM