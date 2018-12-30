create database redmine character set utf8 collate utf8_general_ci;
create user 'redmine'@'%' identified by 'redmine';
grant all privileges on redmine.* to 'redmine'@'%';
flush privileges;