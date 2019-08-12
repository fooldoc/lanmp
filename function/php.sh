#!/bin/sh
set_opcache(){
if [ -s $php_run_path/etc/php.ini ] && grep ';opcache.enable=1' $php_run_path/etc/php.ini;then
echo 'has'
else
sed -i -r '/;opcache.enable=0/a\;开关打开\nopcache.enable=1\n; 可用内存, 酌情而定, 单位 megabytes\nopcache.memory_consumption=128\n;最大缓存的文件数目, 命中率不到 100% 的话, 可以试着提高这个值\nopcache.max_accelerated_files=5000\n;Opcache 会在一定时间内去检查文件的修改时间, 这里设置检查的时间周期, 默认为 2, 单位为秒\nopcache.revalidate_freq=240\n;interned string 的内存大小, 也可调\nopcache.interned_strings_buffer=8\n;是否快速关闭, 打开后在PHP Request Shutdown的时候回收内存的速度会提高\nopcache.fast_shutdown=1\n;不保存文件/函数的注释\nopcache.save_comments=0\n' $php_run_path/etc/php.ini

sed -i -r '/;opcache.enable=0/a\;开关打开\nopcache.enable=1\n; 可用内存, 酌情而定, 单位 megabytes\nopcache.memory_consumption=128\n;最大缓存的文件数目, 命中率不到 100% 的话, 可以试着提高这个值\nopcache.max_accelerated_files=5000\n;Opcache 会在一定时间内去检查文件的修改时间, 这里设置检查的时间周期, 默认为 2, 单位为秒\nopcache.revalidate_freq=240\n;interned string 的内存大小, 也可调\nopcache.interned_strings_buffer=8\n;是否快速关闭, 打开后在PHP Request Shutdown的时候回收内存的速度会提高\nopcache.fast_shutdown=1\n;不保存文件/函数的注释\nopcache.save_comments=0\n' $php_run_path/etc/php.no_disable.ini
fi
}

set_php_variable(){
	local key=$1
	local value=$2
	if grep -q -E "^$key\s*=" $php_run_path/etc/php.ini;then
		sed -i -r "s#^$key\s*=.*#$key=$value#" $php_run_path/etc/php.ini
	else
		sed -i -r "s#;\s*$key\s*=.*#$key=$value#" $php_run_path/etc/php.ini
	fi

	if ! grep -q -E "^$key\s*=" $php_run_path/etc/php.ini;then
		echo "$key=$value" >> $php_run_path/etc/php.ini
	fi
}
set_disable_ini_php_variable(){
	local key=$1
	local value=$2
	if grep -q -E "^$key\s*=" $php_run_path/etc/php.no_disable.ini;then
		sed -i -r "s#^$key\s*=.*#$key=$value#" $php_run_path/etc/php.no_disable.ini
	else
		sed -i -r "s#;\s*$key\s*=.*#$key=$value#" $php_run_path/etc/php.no_disable.ini
	fi

	if ! grep -q -E "^$key\s*=" $php_run_path/etc/php.no_disable.ini;then
		echo "$key=$value" >> $php_run_path/etc/php.no_disable.ini
	fi
}
#配置php
config_php(){	
	#这里这个坑error_log有两行！用特殊写法只替换一次！！
	sed -i -r ':a;N;$!ba;s/\;error_log\s*=\s*syslog/error_log=\/weblog\/php\/php_errors.log/' $php_run_path/etc/php.ini
	set_php_variable disable_functions "checkdnsrr,chgrp,chown,chroot,dl,error_log,exec,ftp_connect,ftp_get,ftp_login,ftp_pasv,getmxrr,getservbyname,getservbyport,gzcompress,gzopen,gzpassthru,highlight_file,ini_alter,ini_restore,openlog,passthru,pfsockopen,popen,popepassthru,posix_ctermid,posix_get_last_error,posix_getcwd,posix_getegid,posix_geteuid,posix_getgid,posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid,posix_getppid,posix_getpwnam,posix_getpwuid,posix_getrlimit,posix_getsid,posix_getuid,posix_isatty,posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid,posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname,proc_close,proc_get_status,proc_open,readlink,scandir,set_time_limit,shell_exec,show_source,socket_accept,socket_bind,socket_listen,stream_socket_accept,stream_socket_client,stream_socket_server,stream_socket_srver,symlink,syslog,system,zlib.compress"
	set_php_variable expose_php Off
	set_php_variable request_order  "CGP"
	set_php_variable cgi.fix_pathinfo 0
	set_php_variable date.timezone Asia/ShangHai
	set_php_variable upload_max_filesize 50M
	set_php_variable post_max_size 50M
	set_php_variable error_reporting E_ALL	
	set_php_variable display_errors Off
	set_php_variable log_errors On
	set_php_variable log_errors_max_len 1024
}
config_php73(){
    sed -i -r ':a;N;$!ba;s/\;error_log\s*=\s*syslog/error_log=\/weblog\/php\/php_errors.log/' $php_run_path/etc/php.ini
    set_php_variable post_max_size 50M
    set_php_variable error_reporting E_ALL
    set_php_variable date.timezone PRC
    set_php_variable expose_php Off
    set_php_variable request_order  "CGP"
    set_php_variable cgi.fix_pathinfo 0
    set_php_variable upload_max_filesize 50M
    set_php_variable display_errors Off
    set_php_variable log_errors On
    set_php_variable log_errors_max_len 1024
    set_php_variable disable_functions "checkdnsrr,chgrp,chown,chroot,dl,error_log,exec,ftp_connect,ftp_get,ftp_login,ftp_pasv,getmxrr,getservbyname,getservbyport,gzcompress,gzopen,gzpassthru,highlight_file,ini_alter,ini_restore,openlog,passthru,pfsockopen,popen,popepassthru,posix_ctermid,posix_get_last_error,posix_getcwd,posix_getegid,posix_geteuid,posix_getgid,posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid,posix_getppid,posix_getpwnam,posix_getpwuid,posix_getrlimit,posix_getsid,posix_getuid,posix_isatty,posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid,posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname,proc_close,proc_get_status,proc_open,readlink,scandir,set_time_limit,shell_exec,show_source,socket_accept,socket_bind,socket_listen,stream_socket_accept,stream_socket_client,stream_socket_server,stream_socket_srver,symlink,syslog,system,zlib.compress"
    set_php_variable zend_extension opcache.so
    set_php_variable opcache.enable 1
    set_php_variable opcache.enable_cli 1
    set_php_variable opcache.fast_shutdown 1
    set_php_variable opcache.memory_consumption 128
    set_php_variable opcache.interned_strings_buffer 8
    set_php_variable opcache.max_accelerated_files 10000
    set_php_variable opcache.validate_timestamps 0
    set_php_variable opcache.revalidate_freq 60
}
#配置CLI专用php ini文件
config_php_no_disable_ini(){
   \cp ${php_run_path}/etc/php.ini ${php_run_path}/etc/php.no_disable.ini
   set_disable_ini_php_variable	memory_limit 256M
   set_disable_ini_php_variable	disable_functions
   set_disable_ini_php_variable max_execution_time 0
}
#安装php7
php7_zip_install(){
#---------安装新版libzip----注意该cmake需要cmake3最新版-----------
tar  zxvf $package_dir/libzip-1.5.0.tar.gz -C $install_dir/
cd $install_dir/libzip-1.5.0
mkdir build
cd build
error_detect "cmake .."
error_detect "make"
error_detect "make install"

# 添加搜索路径到配置文件
echo '/usr/local/lib64
/usr/local/lib
/usr/lib
/usr/lib64'>>/etc/ld.so.conf
# 更新配置
ldconfig -v

}

php73_install(){
#------初始化---------
echo "php73_install 安装开始"
rm -rf /etc/init.d/php-fpm
rm -rf $php_run_path
rm -rf $iconv_run_path

php7_zip_install

#安装libiconv(iconv函数需要用到)
tar zxvf $package_dir/$iconv_pag -C $install_dir/
cd $iconv_path
error_detect "./configure --prefix=${iconv_run_path}"
error_detect "make"
error_detect "make install"
#安装PHP
tar zxvf $package_dir/$php73_pag -C $install_dir/
#7.3 memcached有问题使用7.2
#tar -jxvf $package_dir/$php73_pag -C $install_dir/

cd $php73_path
error_detect "./configure --prefix=${php_run_path} --with-mcrypt --with-config-file-path=${php_run_path}/etc --with-config-file-scan-dir=${php_run_path}/conf.d --with-apxs2=${apache_run_path}/bin/apxs --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir=${iconv_run_path} --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --enable-intl --enable-pcntl --enable-ftp --with-gd --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc  --enable-soap --with-gettext ${with_fileinfo} --enable-opcache --with-xsl ${option_php_config} --enable-ctype --enable-session --enable-zip"
error_detect "make"
error_detect "make install"
echo "Copy new php configure file..."
mkdir -p /usr/local/php/{etc,conf.d}
#-----------------------配置环境变量--------------------------------
php_bin=$php_run_path/bin
if [ -s /etc/profile ] && grep $php_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${php_bin}:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#----------------复制配置文件----------
 #复制phpn ，快速方面使用命令的 phpn 去除 限制的函数的php.ini 执行
 \cp $php_conf/phpn /usr/local/bin/
 \cp $php73_path/php.ini-production ${php_run_path}/etc/php.ini
 chmod 644 ${php_run_path}/etc/php.ini
#-------------修复php.ini-----------
config_php73
config_php_no_disable_ini
set_opcache


}

#安装php
php_install(){
#------初始化---------
rm -rf /etc/init.d/php-fpm
rm -rf $php_run_path
rm -rf $iconv_run_path

#安装libiconv(iconv函数需要用到)
tar zxvf $package_dir/$iconv_pag -C $install_dir/
cd $iconv_path
error_detect "./configure --prefix=${iconv_run_path}"
error_detect "make" 
error_detect "make install"  
#安装PHP
tar zxvf $package_dir/$php_pag -C $install_dir/
cd $php_path
error_detect "./configure --prefix=${php_run_path} --with-apxs2=${apache_run_path}/bin/apxs  --with-config-file-path=${php_run_path}/etc   --enable-sockets --enable-mbstring --with-curl --enable-fpm --enable-zip --with-mcrypt --enable-gd-native-ttf --with-gettext --enable-ftp --enable-bcmath --with-openssl --with-mhash --enable-soap  --with-iconv-dir=${iconv_run_path} --enable-xml --with-libxml-dir --disable-debug --enable-inline-optimization --disable-rpath --enable-mbregex --enable-shmop --enable-sysvsem --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --enable-pcntl --with-xmlrpc  --with-gd --with-jpeg-dir --with-zlib --with-png-dir --with-freetype-dir --enable-ctype --enable-session --enable-opcache ${option_php_config}"
error_detect "make" 
error_detect "make install" 
#-----------------------配置环境变量--------------------------------
php_bin=$php_run_path/bin
if [ -s /etc/profile ] && grep $php_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${php_bin}:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#----------------复制配置文件----------
 #复制phpn ，快速方面使用命令的 phpn 去除 限制的函数的php.ini 执行
 \cp $php_conf/phpn /usr/local/bin/
 #PHP-FPM 不用反向代理单个使用
 \cp $php_conf/php-fpm.conf ${php_run_path}/etc/
 \cp $php_path/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
 chmod +x /etc/init.d/php-fpm
	#sed -i 's/^user =.*/user = ${user_group_web}/' ${php_location}/etc/php-fpm.conf
	#sed -i 's/^group =.*/group = ${user_group_web}/' ${php_location}/etc/php-fpm.conf
 \cp $php_path/php.ini-production ${php_run_path}/etc/php.ini  
 chmod 644 ${php_run_path}/etc/php.ini
#-------------修复php.ini-----------
config_php
config_php_no_disable_ini
set_opcache
}




php54_install(){
#------初始化---------
rm -rf /etc/init.d/php-fpm
rm -rf $php_run_path
rm -rf $iconv_run_path

#安装libiconv(iconv函数需要用到)
tar zxvf $package_dir/$iconv_pag -C $install_dir/
cd $iconv_path
error_detect "./configure --prefix=${iconv_run_path}"
error_detect "make" 
error_detect "make install"  
#安装PHP
tar zxvf $package_dir/$php54_pag -C $install_dir/
cd $php54_path
error_detect "./configure --prefix=${php_run_path} --with-apxs2=${apache_run_path}/bin/apxs --with-config-file-path=${php_run_path}/etc  --enable-sockets --enable-mbstring --with-curl --enable-fpm --enable-zip --with-mcrypt  --enable-gd-native-ttf --with-gettext --enable-ftp --enable-bcmath --with-openssl --with-mhash --enable-soap  --with-iconv-dir=${iconv_run_path} --enable-xml --with-libxml-dir --disable-debug --enable-inline-optimization --disable-rpath --enable-mbregex --enable-shmop --enable-sysvsem --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --enable-pcntl --with-xmlrpc  --with-gd --with-jpeg-dir --with-zlib --with-png-dir --with-freetype-dir --enable-ctype --enable-session ${option_php_config}"
error_detect "make" 
error_detect "make install" 
#-----------------------配置环境变量--------------------------------
php_bin=$php_run_path/bin
if [ -s /etc/profile ] && grep $php_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${php_bin}:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#----------------复制配置文件----------
 #PHP-FPM 不用反向代理单个使用
 \cp $php_conf/php-fpm.conf ${php_run_path}/etc/
 \cp $php54_path/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
 chmod +x /etc/init.d/php-fpm
	#sed -i 's/^user =.*/user = ${user_group_web}/' ${php_location}/etc/php-fpm.conf
	#sed -i 's/^group =.*/group = ${user_group_web}/' ${php_location}/etc/php-fpm.conf
 \cp $php54_path/php.ini-production ${php_run_path}/etc/php.ini
 chmod 644 ${php_run_path}/etc/php.ini
#-------------修复php.ini-----------
config_php
config_php_no_disable_ini
set_opcache
}
