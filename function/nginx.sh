#!/bin/sh
#nginx 1.8.1
nginx_install(){
#-------初始化--------
boot_stop "nginx"
add_group $user_group_web
useradd  -M -s /bin/false -g $user_group_web $user_group_web
killall -9 nginx
rm -rf $nginx_run_path
rm -rf /etc/init.d/nginx
#---------安装----------------
tar zxvf $package_dir/$nginx_pag -C $install_dir/
cd $nginx_path
error_detect "./configure --user=${user_group_web} --group=${user_group_web} --prefix=${nginx_run_path} --with-http_ssl_module --with-http_sub_module --with-http_stub_status_module --with-pcre --with-http_secure_link_module --with-http_gzip_static_module --with-ld-opt='-ljemalloc' --with-http_spdy_module --with-ipv6"
error_detect "make" 
error_detect "make install"
#-------------复制 配置文件----------
mkdir -p $nginx_run_path/conf/vhost
\cp $nginx_conf/host_localhost.conf  $nginx_run_path/conf/vhost/
\cp $nginx_conf/host_localhost_apache.conf  $nginx_run_path/conf/vhost/
\cp $nginx_conf/proxy.conf  $nginx_run_path/conf/vhost/

chmod 644 $nginx_run_path/conf/vhost/host_localhost.conf
chmod 644 $nginx_run_path/conf/vhost/host_localhost_apache.conf
chmod 644 $nginx_run_path/conf/vhost/proxy.conf

mv $nginx_run_path/conf/nginx.conf $nginx_run_path/conf/nginx.conf.old
\cp $nginx_conf/nginx.conf  $nginx_run_path/conf/nginx.conf
chmod 644 $nginx_run_path/conf/nginx.conf
#-----------------------配置环境变量--------------------------------
nginx_bin=$nginx_run_path/sbin
if [ -s /etc/profile ] && grep $nginx_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${nginx_run_path}/sbin:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#------------注册服务设置为开机启动-------------------------
 \cp $nginx_conf/nginx /etc/init.d/nginx
 chmod +x  /etc/init.d/nginx
 boot_start "nginx"
 service nginx start
}



#nginx 1.6
nginx_install1_6(){
#-------初始化--------
boot_stop "nginx"
add_group $user_group_web
useradd  -M -s /bin/false -g $user_group_web $user_group_web
killall -9 nginx
rm -rf $nginx_run_path
rm -rf /etc/init.d/nginx
#---------安装----------------
tar zxvf $package_dir/$nginx_pag -C $install_dir/
cd $nginx_path
error_detect "./configure --user=${user_group_web} --group=${user_group_web} --prefix=${nginx_run_path} --with-http_ssl_module --with-http_sub_module --with-http_stub_status_module --with-pcre --with-http_secure_link_module --with-http_gzip_static_module"
error_detect "make" 
error_detect "make install"
#-------------复制 配置文件----------
mkdir -p $nginx_run_path/conf/vhost
\cp $nginx_conf/host_localhost.conf  $nginx_run_path/conf/vhost/
\cp $nginx_conf/host_localhost_apache.conf  $nginx_run_path/conf/vhost/
chmod 644 $nginx_run_path/conf/vhost/host_localhost.conf
chmod 644 $nginx_run_path/conf/vhost/host_localhost_apache.conf
mv $nginx_run_path/conf/nginx.conf $nginx_run_path/conf/nginx.conf.old
\cp $nginx_conf/nginx.conf  $nginx_run_path/conf/nginx.conf
chmod 644 $nginx_run_path/conf/nginx.conf
#-----------------------配置环境变量--------------------------------
nginx_bin=$nginx_run_path/sbin
if [ -s /etc/profile ] && grep $nginx_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${nginx_run_path}/sbin:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#------------注册服务设置为开机启动-------------------------
 \cp $nginx_conf/nginx /etc/init.d/nginx
 chmod +x  /etc/init.d/nginx
 boot_start "nginx"
 service nginx start
}
