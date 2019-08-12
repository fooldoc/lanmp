#!/bin/sh


php7Memcached(){
#这个只支持7.2
#unzip $package_dir/memcached/php-memcached-php7.zip -d $install_dir/
#cd $install_dir/php-memcached-php7
#这个支持php7.3
tar zxvf $package_dir/memcached/memcached-3.1.3.tgz -C $install_dir/
cd $install_dir/memcached-3.1.3
$php_run_path/bin/phpize
error_detect "./configure --enable-memcached --with-php-config=/usr/local/php/bin/php-config --with-libmemcached-dir=/usr/local/libmemcached/"
error_detect "make"
error_detect "make install"
}

phpMemcached(){
tar zxvf $package_dir/memcached/memcached-2.2.0.tgz -C $install_dir/
cd $install_dir/memcached-2.2.0
$php_run_path/bin/phpize
error_detect "./configure --enable-memcached --with-php-config=/usr/local/php/bin/php-config --with-libmemcached-dir=/usr/local/libmemcached/"
error_detect "make"
error_detect "make install"
}

memcached_install(){
#------初始化------------
boot_stop "memcached"
rm -rf /etc/init.d/memcached
rm -rf /usr/local/memcache
rm -rf /usr/local/memcached
rm -rf /usr/local/libmemcached

#
mkdir -p /var/lock/subsys/
#-------------安装全部依赖包-----------------
if check_sys packageManager apt;then
   	apt-get install libsasl2-2 -y
   	apt-get install sasl2-bin -y
   	apt-get install libsasl2-dev -y
   	apt-get install libsasl2-modules -y
elif check_sys packageManager yum; then
	yum install cyrus-sasl-devel -y
	yum install libevent-devel -y
	Get_Dist_Version
	if echo "${CentOS_Version}" | grep -Eqi '^5.'; then
        yum install gcc44 gcc44-c++ libstdc++44-devel -y
        export CC="gcc44"
        export CXX="g++44"
    fi

fi

#-----------------------------------------安装服务端memcache---------------------------
tar zxvf $package_dir/memcached/memcached-1.5.7.tar.gz -C $install_dir/
cd $install_dir/memcached-1.5.7
error_detect "./configure --prefix=/usr/local/memcache"
error_detect "make"
error_detect "make install"
ln -sf /usr/local/memcached/bin/memcached /usr/bin/memcached

#-------------安装扩展-----------------
tar zxvf $package_dir/memcached/libmemcached-1.0.18.tar.gz -C $install_dir/
cd $install_dir/libmemcached-1.0.18
if gcc -dumpversion|grep -q "^[78]"; then
     patch -p1 < $package_dir/memcached/libmemcached-1.0.18-gcc7.patch
fi
error_detect "./configure --prefix=/usr/local/libmemcached  --with-memcached"
error_detect "make"
error_detect "make install"

if echo "${PHP_Version}" | grep -Eqi '^7.';then
    php7Memcached
    else
    phpMemcached
fi

#设置扩展so的路径
set_php_extension_dir
#在php.ini中引入so扩展文件
set_php_extension_so memcached.so
#------------------------注册服务设置为开机启动-------------------------
\cp $memcached_conf/memcached  /etc/init.d/memcached
chmod 755 /etc/init.d/memcached
boot_start "memcached"

#判断是否存在
if [ -s "${php_config_run_path_origin}/memcached.so" ]; then
        echo "====== memcached installed successfully,======"
        echo "安装成功，请手动重启php服务！"
else
        echo "memcached 安装失败！请将错误信息发给作者！"
fi

}

