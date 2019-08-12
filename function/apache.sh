#!/bin/sh
#2.4+php7
apache_install(){
#单个安装还是一键全部安装，区别在与配置文件是否加上LoadModule php5_module        modules/libphp5.so,防止单个安装启动不了
local type=$1
#-------初始化--------
boot_stop "httpd"
add_group $user_group_web	
useradd  -M -s /bin/false -g $user_group_web $user_group_web
killall httpd
rm -rf $apache_run_path
rm -rf /etc/init.d/httpd

rm -rf ${apr_util_run_path}
rm -rf ${apr_run_path}
rm -rf ${pcre_run_path}

#安装apr
tar -jxvf $package_dir/$apr_pag -C $install_dir/
cd $apr_path
error_detect "./configure --prefix=${apr_run_path}"
error_detect "make" 
error_detect "make install"

#安装apr-util
tar -jxvf $package_dir/$apr_util_pag -C $install_dir/
cd $apr_util_path
error_detect "./configure --prefix=${apr_util_run_path} --with-apr=${apr_run_path}/bin/apr-1-config"
error_detect "make" 
error_detect "make install"

#安装pcre
tar -jxvf $package_dir/$pcre_pag -C $install_dir/
cd $pcre_path
error_detect "./configure --prefix=${pcre_run_path} --with-apr=${apr_run_path}/bin/apr-1-config"
error_detect "make" 
error_detect "make install"

#安装apache
tar zxvf $package_dir/$apache_pag -C $install_dir/
cd $apache_path
error_detect "./configure --prefix=${apache_run_path} --with-pcre=${pcre_run_path} --with-apr=${apr_run_path} --with-apr-util=${apr_util_run_path} --enable-mods-shared=most --enable-headers --enable-mime-magic --enable-proxy --enable-so --enable-rewrite --with-ssl --enable-ssl --enable-deflate --enable-mpms-shared=all --with-mpm=prefork --enable-remoteip"
error_detect "make" 
error_detect "make install"

#-------------复制 配置文件----------------

mv $apache_run_path/conf/extra/httpd-vhosts.conf $apache_run_path/conf/extra/httpd-vhosts.conf.old
mv $apache_run_path/conf/httpd.conf $apache_run_path/conf/http.conf.old
mv $apache_run_path/conf/extra/httpd-default.conf $apache_run_path/conf/extra/httpd-default.conf.old
mv $apache_run_path/conf/extra/mod_remoteip.conf $apache_run_path/conf/extra/mod_remoteip.conf.old
mkdir -p $apache_run_path/conf/vhost


if [ "$type" == "1" ];then
＃如果使用的是php7
\cp $apache_conf/httpd24-php7-lnmpa.conf $apache_run_path/conf/httpd.conf
else
＃如果使用的是php5
\cp $apache_conf/httpd24-lnmpa.conf $apache_run_path/conf/httpd.conf
fi

\cp $apache_conf/httpd24-vhosts-lnmpa.conf $apache_run_path/conf/extra/httpd-vhosts.conf
\cp $apache_conf/httpd-default.conf $apache_run_path/conf/extra/httpd-default.conf
\cp $apache_conf/mod_remoteip.conf $apache_run_path/conf/extra/mod_remoteip.conf

chmod 644 $apache_run_path/conf/extra/*
chmod 644 $apache_run_path/conf/httpd.conf
#-----------------------配置环境变量--------------------------------
apache_bin=$apache_run_path/bin
if [ -s /etc/profile ] && grep $apache_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${apache_run_path}/bin:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#------------------------注册服务设置为开机启动-------------------------
 \cp $apache_conf/httpd /etc/init.d/httpd
 chmod +x  /etc/init.d/httpd
 boot_start "httpd"
 service httpd start
}
#-------------------------
#apache2.2安装
#--------------------------
apache_install2_2(){
#单个安装还是一键全部安装，区别在与配置文件是否加上LoadModule php5_module        modules/libphp5.so,防止单个安装启动不了
local type=$1
#-------初始化--------
boot_stop "httpd"
add_group $user_group_web	
useradd  -M -s /bin/false -g $user_group_web $user_group_web
killall httpd
rm -rf $apache_run_path
rm -rf /etc/init.d/httpd
#安装apache
tar zxvf $package_dir/$apache_pag -C $install_dir/
cd $apache_path
error_detect "./configure --prefix=${apache_run_path} --with-included-apr --enable-so --enable-deflate=shared --enable-expires=shared  --enable-ssl=shared --enable-headers=shared --enable-rewrite=shared --enable-static-support --with-ssl"
error_detect "make" 
error_detect "make install"

#-------------复制 配置文件----------------
rm -rf $apache_run_path/conf/extra/httpd-mpm.conf
rm -rf $apache_run_path/conf/extra/httpd-vhosts.conf
mv $apache_run_path/conf/httpd.conf $apache_run_path/conf/http.conf.old
mkdir -p $apache_run_path/conf/vhost

\cp $apache_conf/httpd-mpm.conf  $apache_run_path/conf/extra/

if [ "$type" == "1" ];then
\cp $apache_conf/httpd1.conf  $apache_run_path/conf/httpd.conf
else
\cp $apache_conf/httpd.conf  $apache_run_path/conf/httpd.conf	
fi

\cp $apache_conf/httpd-vhosts.conf $apache_run_path/conf/extra/

chmod 644 $apache_run_path/conf/extra/httpd-mpm.conf
chmod 644 $apache_run_path/conf/extra/httpd-vhosts.conf
chmod 644 $apache_run_path/conf/httpd.conf
#-----------------------配置环境变量--------------------------------
apache_bin=$apache_run_path/bin
if [ -s /etc/profile ] && grep $apache_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${apache_run_path}/bin:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#------------------------注册服务设置为开机启动-------------------------
 \cp $apache_conf/httpd /etc/init.d/httpd
 chmod +x  /etc/init.d/httpd
 boot_start "httpd"
 service httpd start
}


