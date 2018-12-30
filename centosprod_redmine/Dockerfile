#furywolf/centosprod 기반으로 만든 furywolf/centosprod_redmine 이미지

FROM furywolf/centosprod

MAINTAINER Terry Chang <furywolf@hanmail.net>

ENV REDMINE_VERSION=3.4.7

ADD resources /resources
COPY /resources/mariadb.repo /etc/yum.repos.d

RUN yum clean all \
&& yum update -y \
&& yum install -y expect MariaDB-client MariaDB-server \
&& cp /resources/my.cnf /etc \
&& systemctl enable mariadb.service \
&& mysql_install_db \
&& /etc/init.d/mysql start \
&& chmod +x /resources/mariadb_secure_init.sh \
&& /resources/mariadb_secure_init.sh \
&& mysql -uroot -proot < /resources/redmine_database.sql \
&& yum -y install php php-mysql php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel \
&& systemctl enable httpd.service \
&& /bin/bash -l -c "httpd -k restart " \
&& yum -y install gpg2 libyaml-devel glibc-headers autoconf gcc-c++ glibc-devel patch readline-devel zlib-devel libffi-devel \
openssl-devel automake libtool bison sqlite-devel \
&& gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
&& curl -sSL https://rvm.io/mpapis.asc | gpg --import - \
&& curl -sSL https://get.rvm.io | bash -s stable \
&& source /etc/profile.d/rvm.sh \
&& /bin/bash -l -c "rvm reload" \
&& /bin/bash -l -c "rvm requirements run" \
&& /bin/bash -l -c "rvm install 2.5" \
&& /bin/bash -l -c "rvm use 2.5 --default" \
&& /bin/bash -l -c "gem install rails -V" \
&& /bin/bash -l -c "gem install bundler --no-rdoc --no-ri" \
&& cd /var/www/html \
&& wget http://www.redmine.org/releases/redmine-$REDMINE_VERSION.tar.gz \
&& tar -xvzf redmine-$REDMINE_VERSION.tar.gz \
&& mv redmine-$REDMINE_VERSION redmine \
&& rm redmine-$REDMINE_VERSION.tar.gz \
&& cp /resources/database.yml /var/www/html/redmine/config \
&& cd /var/www/html/redmine \
&& yum -y install MariaDB-shared mysql-devel bzip2-devel freetype-devel ghostscript-devel jasper-devel libX11-devel libXext-devel libXt-devel libjpeg-devel libtiff-devel \
&& yum -y install ImageMagick ImageMagick-devel \
&& /bin/bash -l -c "bundle install --without development test" \
&& /bin/bash -l -c "bundle exec rake generate_secret_token" \
&& /bin/bash -l -c "bundle exec rake db:migrate RAILS_ENV=production" \
&& /bin/bash -l -c "bundle exec rake redmine:load_default_data RAILS_ENV=production REDMINE_LANG=ko" \
&& /bin/bash -l -c "gem install passenger" \
&& yum -y install httpd-devel apr-devel apr-util-devel \
&& /bin/bash -l -c "passenger-install-apache2-module --languages ruby" \
&& cp /resources/redmine.conf /etc/httpd/conf.d \
&& cd /var/www/html \
&& chown -R apache:apache redmine \
&& /etc/init.d/mysql restart \
&& /bin/bash -l -c "httpd -k restart "

EXPOSE 21 22 80 3306 8080 64000-64010

ADD resources/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh
ENTRYPOINT ["/usr/local/bin/init.sh"]
