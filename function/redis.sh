#!/bin/sh


redis_install(){
Get_OS_Bit
#------初始化------------
boot_stop "redis"
rm -rf /etc/init.d/redis
rm -rf /usr/local/redis
#-----------------------------------------安装服务端redis---------------------------
tar zxvf $package_dir/redis/redis-4.0.9.tar.gz -C $install_dir/
cd $install_dir/redis-4.0.9

if [ "${Is_64bit}" = "y" ] ; then
     error_detect "make PREFIX=/usr/local/redis install"
   else
     error_detect "make CFLAGS=\"-march=i686\" PREFIX=/usr/local/redis install"
fi


mkdir -p /usr/local/redis/etc/
\cp redis.conf  /usr/local/redis/etc/
sed -i 's/daemonize no/daemonize yes/g' /usr/local/redis/etc/redis.conf
sed -i 's/^# bind 127.0.0.1/bind 127.0.0.1/g' /usr/local/redis/etc/redis.conf
#防火墙端口号支持 +判断 yum 判断是否有登入
if [ -s /sbin/iptables ] && check_sys packageManager yum; then
   /sbin/iptables -A INPUT -p tcp --dport 6379 -j DROP
   service iptables save
fi
#-------------安装扩展-----------------
  if echo "${PHP_Version}" | grep -Eqi '^5.2.';then
        tar zxvf $package_dir/redis/redis-2.2.7.tgz -C $install_dir/
        cd $install_dir/redis-2.2.7
    else
       tar zxvf $package_dir/redis/redis-4.0.2.tgz -C $install_dir/
       cd $install_dir/redis-4.0.2
    fi


$php_run_path/bin/phpize
error_detect "./configure --with-php-config=${php_run_path}/bin/php-config"
error_detect "make"
error_detect "make install"

#设置扩展so的路径
set_php_extension_dir
#在php.ini中引入so扩展文件
set_php_extension_so redis.so
#------------------------注册服务设置为开机启动-------------------------
\cp $redis_conf/redis  /etc/init.d/redis
chmod 755 /etc/init.d/redis
boot_start "redis"
#判断是否存在
if [ -s "${php_config_run_path_origin}/redis.so" ] && [ -s /usr/local/redis/bin/redis-server ]; then
        echo "====== Redis installed successfully,======"
        echo "安装成功，请手动重启php服务！"
else
        echo "Redis 安装失败！请将错误信息发给作者！"
fi

}

