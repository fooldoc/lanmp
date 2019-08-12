#!/bin/sh
#初始化安装
init_web_install(){
#rpm -e mod_ssl
#rpm -e mod_python
#rpm -e mod_perl
#rpm -e php
#rpm -e webalizer
#rpm -e gnome-user-share
#rpm -e httpd-manual
#rpm -e system-config-httpd
#rpm -e httpd



#-------------安装全部依赖包-----------------
if check_sys packageManager apt;then
   	ubuntu_all_package_install     
elif check_sys packageManager yum; then
	centos_all_package_install
fi

ln -s /usr/bin/cmake3 /usr/bin/cmake

#-----------------------初始化文件夹------------------------------------
groupadd $user_group_web
useradd -g $user_group_web $user_group_web -s /bin/false
mkdir -p /$web_path
chown -R $user_group_web:$user_group_web /$web_path
#有空回来修改一下默认nginx apache 的 log 路径
mkdir -p /$web_log_path/nginx
mkdir -p /$web_log_path/apache

mkdir -p /$web_log_path/php
mkdir -p /$web_log_path/web/dev
mkdir -p /$web_log_path/web/lct
mkdir -p /$web_log_path/web/pro
mkdir -p /$web_log_path/cli/dev
mkdir -p /$web_log_path/cli/lct
mkdir -p /$web_log_path/cli/pro
mkdir -p /$web_log_path/crontab/dev
mkdir -p /$web_log_path/crontab/lct
mkdir -p /$web_log_path/crontab/pro
mkdir /$web_resource_path
chmod 740 -R /$web_log_path
chown -R $user_group_web:$user_group_web /$web_log_path
chmod 740 -R /$web_resource_path
chown -R $user_group_web:$user_group_web /$web_resource_path
}
#注意如果缺少某个软件包，会跳过全部的安装，所以安装web环境出错的时候记得回来看下
ubuntu_all_package_install(){
apt-get update 
apt-get install gcc -y
apt-get install g++ -y
apt-get install make -y
apt-get install wget -y
apt-get install perl -y
apt-get install curl -y
apt-get install bzip2 -y
apt-get install zlib1g-dev m4 bison autoconf -y
apt-get install pkg-config openssl libxml2 libxml2-dev libpcre3-dev -y 
apt-get install libjpeg-dev -y
apt-get install libpng12-dev -y
apt-get install libssl-dev -y
apt-get install libfreetype6-dev -y
apt-get install libmhash-dev -y
apt-get install libmcrypt-dev -y
apt-get install libcurl4-gnutls-dev -y
apt-get install autoconf2.13 -y
apt-get install libncurses5-dev -y
apt-get install libevent-dev -y
apt-get install build-essential -y
apt-get install automake -y
apt-get install lynx -y
apt-get install autotools-dev -y
apt-get install cpp -y
apt-get install libc6-dev -y
apt-get install libpcrecpp0 -y
apt-get install linux-libc-dev -y
apt-get install libtool* -y
apt-get install libtool -y
apt-get install libicu-dev -y
apt-get install libxslt -y
apt-get install libxslt1-dev -y
apt-get install cmake3 -y  #旧版cmake编译libzip失败
#apt-get install libzip-dev -y  #旧版php7以下可以用
apt-get install libexpat1-dev
}

centos_all_package_install(){
yum  update -y
yum  install epel-release -y
yum  update -y
yum install gd -y
yum install gd-devel -y
yum install gcc -y
yum install gcc-c++ -y
yum install autoconf -y
yum install automake -y
yum install libtool -y
yum install libtool-ltdl-devel -y
yum install flex -y
yum install bison -y
yum install libpng -y
yum install libpng-devel -y
yum install libxml2 -y
yum install libxml2-devel -y
yum install zlib -y
yum install zlib-devel -y
yum install curl -y
yum install curl-devel -y
yum install freetype -y
yum install freetype-devel -y
yum install glibc -y
yum install glibc-devel -y
yum install glib2 -y
yum install glib2-devel -y
yum install bzip2 -y
yum install bzip2-devel -y
yum install openssl -y
yum install openssl-devel -y
yum install lynx -y
yum install openldap -y
yum install openldap-devel -y
yum install nss_ldap -y
yum install openldap-clients -y
yum install openldap-servers -y
yum install ncurses -y
yum install ncurses-devel -y
yum install e2fsprogs -y
yum install e2fsprogs-devel -y
yum install krb5 -y
yum install krb5-devel -y
yum install libidn -y
yum install libidn-devel -y
yum install gettext -y
yum install libjpeg -y
yum install libjpeg-devel -y
yum install glibc -y
yum install glibc-devel -y
yum install glib2 -y
yum install glib2-devel -y
yum install unzip -y
yum install pcre-devel -y
yum install kernel-devel -y
yum install gettext-devel -y
yum install libcap-devel -y
yum install readline-devel -y
yum install make -y
yum install libevent-devel -y
yum install libmcrypt -y
yum install libmcrypt-devel -y
yum install mcrypt -y
yum install mhash -y
#yum install cmake -y
yum install libicu-devel -y
yum install libxslt -y
yum install libxslt-devel -y
yum install cmake3 -y
#yum install libzip-devel -y　　#旧版php7以下可以用
}

  
