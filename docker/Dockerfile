#installing php7 is not requried because by default we get phph 7.2 comes along rehel 8 version.

dnf module enable php:7.4
dnf install httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb php-mbstring php-json mod_ssl php-intl php-apcu
systemctl start mariadb
mysql_secure_installation

#Start Apache and MySQL on boot. For RHEL 8:
systemctl enable mariadb
systemctl enable httpd

cd /var/www && ln -s mediawiki-1.41.0/ mediawiki && chown -R apache:apache /var/www/mediawiki-1.41.0
service httpd restart

#installing WIKIMEDIA

RUN wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.0.tar.gz &&\
    tar mediawiki-1.41.0.tar.gz &&\
    rm -rf mediawiki-1.41.0.tar.gz &&\
    mv mediawiki-1.41.0 /usr/local/apache2/htdocs/ &&\
    mv /usr/local/apache2/htdocs/mediawiki-1.41.0 /usr/local/apache2/htdocs/wiki

CMD /usr/local/apache2/bin/apachectl -DFOREGROUND
EXPOSE 80
