#!/bin/sh

Install_Boost()
{
    if check_sys packageManager apt;then
         #apt-get update
    	 apt-get install -y python-dev
    elif check_sys packageManager yum; then
	     yum -y install python-devel
    fi
    tar -jxvf $package_dir/$boost_pag -C $install_dir/
}

MySQL_Opt()
{
    if [[ ${MemTotal} -gt 1024 && ${MemTotal} -lt 2048 ]]; then
        sed -i "s#^key_buffer_size.*#key_buffer_size = 32M#" /etc/my.cnf
        sed -i "s#^table_open_cache.*#table_open_cache = 128#" /etc/my.cnf
        sed -i "s#^sort_buffer_size.*#sort_buffer_size = 768K#" /etc/my.cnf
        sed -i "s#^read_buffer_size.*#read_buffer_size = 768K#" /etc/my.cnf
        sed -i "s#^myisam_sort_buffer_size.*#myisam_sort_buffer_size = 8M#" /etc/my.cnf
        sed -i "s#^thread_cache_size.*#thread_cache_size = 16#" /etc/my.cnf
        sed -i "s#^query_cache_size.*#query_cache_size = 16M#" /etc/my.cnf
        sed -i "s#^tmp_table_size.*#tmp_table_size = 32M#" /etc/my.cnf
        sed -i "s#^innodb_buffer_pool_size.*#innodb_buffer_pool_size = 128M#" /etc/my.cnf
        sed -i "s#^innodb_log_file_size.*#innodb_log_file_size = 32M#" /etc/my.cnf
        sed -i "s#^performance_schema_max_table_instances.*#performance_schema_max_table_instances = 1000#" /etc/my.cnf
    elif [[ ${MemTotal} -ge 2048 && ${MemTotal} -lt 4096 ]]; then
        sed -i "s#^key_buffer_size.*#key_buffer_size = 64M#" /etc/my.cnf
        sed -i "s#^table_open_cache.*#table_open_cache = 256#" /etc/my.cnf
        sed -i "s#^sort_buffer_size.*#sort_buffer_size = 1M#" /etc/my.cnf
        sed -i "s#^read_buffer_size.*#read_buffer_size = 1M#" /etc/my.cnf
        sed -i "s#^myisam_sort_buffer_size.*#myisam_sort_buffer_size = 16M#" /etc/my.cnf
        sed -i "s#^thread_cache_size.*#thread_cache_size = 32#" /etc/my.cnf
        sed -i "s#^query_cache_size.*#query_cache_size = 32M#" /etc/my.cnf
        sed -i "s#^tmp_table_size.*#tmp_table_size = 64M#" /etc/my.cnf
        sed -i "s#^innodb_buffer_pool_size.*#innodb_buffer_pool_size = 256M#" /etc/my.cnf
        sed -i "s#^innodb_log_file_size.*#innodb_log_file_size = 64M#" /etc/my.cnf
        sed -i "s#^performance_schema_max_table_instances.*#performance_schema_max_table_instances = 2000#" /etc/my.cnf
    elif [[ ${MemTotal} -ge 4096 && ${MemTotal} -lt 8192 ]]; then
        sed -i "s#^key_buffer_size.*#key_buffer_size = 128M#" /etc/my.cnf
        sed -i "s#^table_open_cache.*#table_open_cache = 512#" /etc/my.cnf
        sed -i "s#^sort_buffer_size.*#sort_buffer_size = 2M#" /etc/my.cnf
        sed -i "s#^read_buffer_size.*#read_buffer_size = 2M#" /etc/my.cnf
        sed -i "s#^myisam_sort_buffer_size.*#myisam_sort_buffer_size = 32M#" /etc/my.cnf
        sed -i "s#^thread_cache_size.*#thread_cache_size = 64#" /etc/my.cnf
        sed -i "s#^query_cache_size.*#query_cache_size = 64M#" /etc/my.cnf
        sed -i "s#^tmp_table_size.*#tmp_table_size = 64M#" /etc/my.cnf
        sed -i "s#^innodb_buffer_pool_size.*#innodb_buffer_pool_size = 512M#" /etc/my.cnf
        sed -i "s#^innodb_log_file_size.*#innodb_log_file_size = 128M#" /etc/my.cnf
        sed -i "s#^performance_schema_max_table_instances.*#performance_schema_max_table_instances = 4000#" /etc/my.cnf
    elif [[ ${MemTotal} -ge 8192 && ${MemTotal} -lt 16384 ]]; then
        sed -i "s#^key_buffer_size.*#key_buffer_size = 256M#" /etc/my.cnf
        sed -i "s#^table_open_cache.*#table_open_cache = 1024#" /etc/my.cnf
        sed -i "s#^sort_buffer_size.*#sort_buffer_size = 4M#" /etc/my.cnf
        sed -i "s#^read_buffer_size.*#read_buffer_size = 4M#" /etc/my.cnf
        sed -i "s#^myisam_sort_buffer_size.*#myisam_sort_buffer_size = 64M#" /etc/my.cnf
        sed -i "s#^thread_cache_size.*#thread_cache_size = 128#" /etc/my.cnf
        sed -i "s#^query_cache_size.*#query_cache_size = 128M#" /etc/my.cnf
        sed -i "s#^tmp_table_size.*#tmp_table_size = 128M#" /etc/my.cnf
        sed -i "s#^innodb_buffer_pool_size.*#innodb_buffer_pool_size = 1024M#" /etc/my.cnf
        sed -i "s#^innodb_log_file_size.*#innodb_log_file_size = 256M#" /etc/my.cnf
        sed -i "s#^performance_schema_max_table_instances.*#performance_schema_max_table_instances = 6000#" /etc/my.cnf
    elif [[ ${MemTotal} -ge 16384 && ${MemTotal} -lt 32768 ]]; then
        sed -i "s#^key_buffer_size.*#key_buffer_size = 512M#" /etc/my.cnf
        sed -i "s#^table_open_cache.*#table_open_cache = 2048#" /etc/my.cnf
        sed -i "s#^sort_buffer_size.*#sort_buffer_size = 8M#" /etc/my.cnf
        sed -i "s#^read_buffer_size.*#read_buffer_size = 8M#" /etc/my.cnf
        sed -i "s#^myisam_sort_buffer_size.*#myisam_sort_buffer_size = 128M#" /etc/my.cnf
        sed -i "s#^thread_cache_size.*#thread_cache_size = 256#" /etc/my.cnf
        sed -i "s#^query_cache_size.*#query_cache_size = 256M#" /etc/my.cnf
        sed -i "s#^tmp_table_size.*#tmp_table_size = 256M#" /etc/my.cnf
        sed -i "s#^innodb_buffer_pool_size.*#innodb_buffer_pool_size = 2048M#" /etc/my.cnf
        sed -i "s#^innodb_log_file_size.*#innodb_log_file_size = 512M#" /etc/my.cnf
        sed -i "s#^performance_schema_max_table_instances.*#performance_schema_max_table_instances = 8000#" /etc/my.cnf
    elif [[ ${MemTotal} -ge 32768 ]]; then
        sed -i "s#^key_buffer_size.*#key_buffer_size = 1024M#" /etc/my.cnf
        sed -i "s#^table_open_cache.*#table_open_cache = 4096#" /etc/my.cnf
        sed -i "s#^sort_buffer_size.*#sort_buffer_size = 16M#" /etc/my.cnf
        sed -i "s#^read_buffer_size.*#read_buffer_size = 16M#" /etc/my.cnf
        sed -i "s#^myisam_sort_buffer_size.*#myisam_sort_buffer_size = 256M#" /etc/my.cnf
        sed -i "s#^thread_cache_size.*#thread_cache_size = 512#" /etc/my.cnf
        sed -i "s#^query_cache_size.*#query_cache_size = 512M#" /etc/my.cnf
        sed -i "s#^tmp_table_size.*#tmp_table_size = 512M#" /etc/my.cnf
        sed -i "s#^innodb_buffer_pool_size.*#innodb_buffer_pool_size = 4096M#" /etc/my.cnf
        sed -i "s#^innodb_log_file_size.*#innodb_log_file_size = 1024M#" /etc/my.cnf
        sed -i "s#^performance_schema_max_table_instances.*#performance_schema_max_table_instances = 10000#" /etc/my.cnf
    fi
}

mysql_init_base(){
#------初始化---------
boot_stop "mysql"
add_group mysql
useradd -g mysql mysql -s /bin/false
mkdir -p $mysql_run_path
mkdir -p $mysql_run_path/data
chown -R mysql:mysql $mysql_run_path/data
rm -rf $cmake_run_path
rm -rf $mysql_run_path
rm -rf /etc/my.cnf
mkdir -p /$web_log_path/mysql
touch /$web_log_path/mysql/mysql_error.log
chown -R mysql:mysql /$web_log_path/mysql
}

mysql_install(){

mysql_init_base
#安装cmake
tar zxvf $package_dir/$cmake_pag -C $install_dir/
cd $cmake_path
error_detect "./configure --prefix=${cmake_run_path}"
error_detect "make" 
error_detect "make install"
#安装mysql
tar zxvf $package_dir/$mysql_pag -C $install_dir/
cd $mysql_path
mysql_configure="${cmake_run_path}/bin/cmake ./ -DCMAKE_INSTALL_PREFIX=${mysql_run_path} -DMYSQL_DATADIR=${mysql_run_path}/data -DSYSCONFDIR=/etc -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DCMAKE_EXE_LINKER_FLAGS='-ljemalloc' -DWITH_SAFEMALLOC=OFF"
error_detect "$mysql_configure"
error_detect "make"
error_detect "make install"
#------------------初始化mysql----------------------
cd $mysql_run_path/
rm -rf my-new.cnf
rm -rf my.cnf
\cp ${mysql_conf}/my.cnf /etc/my.cnf
chmod 644 /etc/my.cnf
cd $mysql_run_path/scripts
./mysql_install_db --user=mysql --basedir=$mysql_run_path --datadir=$mysql_run_path/data
#-----------------------配置环境变量--------------------------------
mysql_bin=$mysql_run_path/bin
if [ -s /etc/profile ] && grep $mysql_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${mysql_run_path}/bin:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#------------------------注册服务设置为开机启动-------------------------
 \cp $mysql_run_path/support-files/mysql.server /etc/init.d/mysql
 chmod +x  /etc/init.d/mysql
boot_start "mysql"
#启动mysql
service mysql start
#初始化密码
$mysql_run_path/bin/mysqladmin -u root password 'root'
}

mysql_install_80()
{
   mysql_init_base
   #个人服务器总内存为2G，内存不够安装8.0－－－－－创建交换分区 并 开启－－－－－
   dd if=/dev/zero of=/swapfile bs=64M count=16
   mkswap /swapfile
   swapon /swapfile


   Install_Boost
  #安装mysql
  tar zxvf $package_dir/$mysql80_pag -C $install_dir/
  cd $mysql80_path
    mysql_configure="cmake -DCMAKE_INSTALL_PREFIX=${mysql80_run_path} -DSYSCONFDIR=/etc -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_general_ci -DWITH_EMBEDDED_SERVER=1 -DENABLED_LOCAL_INFILE=1 -DWITH_BOOST=${boost_path}"
    error_detect "$mysql_configure"
    error_detect "make"
    error_detect "make install"
    cat > /etc/my.cnf<<EOF
[client]
#password   = your_password
port        = 3306
socket      = /tmp/mysql.sock
[mysqld]
port        = 3306
socket      = /tmp/mysql.sock
datadir = ${mysql80_run_path}/data
skip-external-locking
key_buffer_size = 16M
max_allowed_packet = 1M
table_open_cache = 64
sort_buffer_size = 512K
net_buffer_length = 8K
read_buffer_size = 256K
read_rnd_buffer_size = 512K
myisam_sort_buffer_size = 8M
thread_cache_size = 8
tmp_table_size = 16M
performance_schema_max_table_instances = 500

explicit_defaults_for_timestamp = true
#skip-networking
max_connections = 500
max_connect_errors = 100
open_files_limit = 65535
default_authentication_plugin = mysql_native_password

log-bin=mysql-bin
binlog_format=mixed
server-id   = 1
binlog_expire_logs_seconds = 864000
early-plugin-load = ""

default_storage_engine = InnoDB
innodb_file_per_table = 1
innodb_data_home_dir = ${mysql80_run_path}/data
innodb_data_file_path = ibdata1:10M:autoextend
innodb_log_group_home_dir = ${mysql80_run_path}/data
innodb_buffer_pool_size = 16M
innodb_log_file_size = 5M
innodb_log_buffer_size = 8M
innodb_flush_log_at_trx_commit = 1
innodb_lock_wait_timeout = 50
sql_mode=ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
[mysqldump]
quick
max_allowed_packet = 16M
user=root
password=root

[mysql]
no-auto-rehash
[myisamchk]
key_buffer_size = 20M
sort_buffer_size = 20M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout

[mysqld_safe]
malloc-lib=/usr/lib/libjemalloc.so

EOF
#----------安装完成后可以关闭交换分区 并删除交换分区 文件－－－－－－－－－－
swapoff /swapfile
rm -rf /swapfile
#------------------初始化mysql----------------------
MySQL_Opt
cd $mysql80_run_path/
chmod 644 /etc/my.cnf
/usr/local/mysql/bin/mysqld --initialize-insecure --basedir=${mysql80_run_path} --datadir=${mysql80_run_path}/data --user=mysql
#-----------------------配置环境变量--------------------------------
mysql_bin=$mysql80_run_path/bin
if [ -s /etc/profile ] && grep $mysql_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${mysql80_run_path}/bin:\
\$PATH
export PATH
EOF
fi
source /etc/profile
#------------------------注册服务设置为开机启动-------------------------
 \cp $mysql80_run_path/support-files/mysql.server /etc/init.d/mysql
 chmod +x  /etc/init.d/mysql
boot_start "mysql"
#启动mysql
service mysql start
#初始化密码
$mysql80_run_path/bin/mysqladmin -u root password 'root'


}

