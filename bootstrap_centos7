# #!/usr/bin/env bash
yum -y install wget net-tools unzip vim bc git

yum -y install firewalld
systemctl unmask firewalld
systemctl enable firewalld
systemctl start firewalld

wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

yum update -y
##[PHP]
yum install -y php56w \
php56w-bcmath \
php56w-gd \
php56w-mbstring \
php56w-mcrypt-* \
php56w-mysql \
php56w-pdo \
php56w-pear \
php56w-pecl-apc \
php56w-soap \
php56w-tidy \
php56w-xml \
php56w-ldap \
php56w-cli \
php56w-common \
php56w-process
# yum -y replace php-common --replace-with=php55w-common
# yum install php55w-pgsql

##[APACHE]
yum -y install httpd mod_ssl
chkconfig httpd on

sed -i 's/;date.timezone =.*/  date.timezone \= "America\/Lima"/' /etc/php.ini
systemctl start httpd
firewall-cmd --permanent --zone=public --add-service=http
# firewall-cmd --permanent --zone=public --add-service=https
#firewall-cmd --permanent --zone=public --add-port=3306/tcp
firewall-cmd --reload
echo "<?php phpinfo(); ?>" > /var/www/html/info.php

##[MYSQL]
yum -y install yum-plugin-replace
yum -y install mysql mysql-server
chkconfig mysqld on
systemctl start mysqld
/usr/bin/mysql_secure_installation

yum -y install phpmyadmin
# sudo vim /etc/httpd/conf.d/phpMyAdmin.conf
# <IfModule mod_authz_core.c>
#   # Apache 2.4
#   <RequireAny>
#     Require ip 127.0.0.1
#     Require ip ::1
#     #Require all granted
#   </RequireAny>
# </IfModule>
# vim /etc/phpMyAdmin/config.inc.php
# #$cfg['LoginCookieValidity'] = 36000;
# #$cfg['ForceSSL'] = true;
systemctl restart httpd

##[COMPOSER]
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
mv /usr/bin/composer.phar /usr/bin/composer
# php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# php composer-setup.php --install-dir=/usr/bin

##[APACHE HTTPS]
# sudo yum install mod_ssl
# sudo mkdir /etc/httpd/ssl
# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/httpd/ssl/apache.key -out /etc/httpd/ssl/apache.crt
# sudo vi /etc/httpd/conf.d/ssl.conf
# DocumentRoot "/var/www/example.com/public_html"
# ServerName www.example.com:443
# SSLCertificateFile /etc/httpd/ssl/apache.crt
# SSLCertificateKeyFile /etc/httpd/ssl/apache.key
# sudo apachectl restart

##[POSTGRESQL]
##
# sudo yum install postgresql-server postgresql-contrib
# sudo postgresql-setup initdb
# sudo vim /var/lib/pgsql/data/pg_hba.conf
# # host    all             all             127.0.0.1/32            ident
# # host    all             all             ::1/128                 ident
# sudo systemctl start postgresql
# sudo systemctl enable postgresql
## CAMBIAR PASSWORD POSTGRES
# su - postgres
# psql
# postgres=# \password postgres
# Enter new password:
# Enter it again:
# postgres=# \q
#
## ADMINPACK
# postgres=# CREATE EXTENSION adminpack;
# CREATE EXTENSION
#
## CREAR USUARIO
# su - postgres
# createuser senthil
# createdb mydb
# psql
# postgres=# alter user senthil with encrypted password 'centos';
# ALTER ROLE
# postgres=# grant all privileges on database mydb to senthil;
# GRANT
# postgres=# ALTER ROLE senthil WITH SUPERUSER CREATEDB;
# ALTER ROLE
#
## ACCESO REMOTO
# sudo vim /var/lib/pgsql/data/postgresql.conf
# #listen_addresses = "*"
# sudo vim /var/lib/pgsql/data/pg_hba.conf
# #ADD
# ##host    all             all             192.168.1.1/24                 md5
# firewall-cmd --permanent --zone=public --add-service=postgresql
# systemctl restart firewalld.service
# systemctl restart postgresql
#netstat -antup | grep 5432

##[SAMBA]
## CREAR CARPETA COMPARTIDA PUBLICA
# mkdir -p /home/samba/folder
# chmod -R 0755 /home/samba/folder/
# chown -R nobody:nobody /home/samba/folder/
#
# yum install samba samba-client samba-common
# cp /etc/samba/smb.conf /etc/samba/smb.conf.old
# vim /etc/samba/smb.conf
## workgroup = WORKGROUP
## hosts allow = 192.168.1.
## security = user
## map to guest = bad user
##[folder]
## comment = Sistema folder
## path = /home/samba/folder
## browsable = yes
## writable = yes
## read only = no
## guest ok = yes
#
# systemctl start smb nmb
# systemctl enable smb nmb
# firewall-cmd --add-service=samba --permanent
# firewall-cmd --reload
#
##[SSH]
# vim /etc/ssh/sshd_config
## Port 22xx
## PermitRootLogin no
# systemctl reload sshd
# sudo firewall-cmd --permanent --add-port=22xx/tcp
# sudo firewall-cmd --reload
#
##[GRUB]
# cp /etc/default/grub /etc/default/grub.old
# vim /etc/default/grub
##GRUB_TIMEOUT=0
# grub2-mkconfig -o /boot/grub2/grub.cfg
#
##[HOSTNAME]
#nmtui
#systemctl restart systemd-hostnamed
#hostnamectl status
#
##[HOST VIRTUAL]
#mkdir /etc/httpd/vhosts
# vim /etc/httpd/vhosts/domain.com.conf
# vim /etc/httpd/conf/httpd.conf
# systemctl restart httpd
#
##[MONGODB]
# vim /etc/yum.repos.d/mongodb-org-3.2.repo
## [mongodb-org-3.2]
## name=MongoDB Repository
## baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
## gpgcheck=1
## enabled=1
## gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
# yum install -y mongodb-org
# chkconfig mongod on
# service mongod start
#
##[REMOVER MONGODB]
# service mongod stop
# yum erase $(rpm -qa | grep mongodb-org)
# rm -r /var/log/mongodb
# rm -r /var/lib/mongo
#
##[ABRIR PUERTO MONGODB]
# firewall-cmd --zone=public --add-port=27017/tcp --permanent
# firewall-cmd --reload
# telnet 10.1.1.99  27017
