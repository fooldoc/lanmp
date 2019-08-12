#!/bin/bash
remove_all(){
killall httpd
boot_stop httpd
rm -rf $apache_run_path
rm -rf /etc/init.d/httpd


service mysql stop
boot_stop mysql
rm -rf $cmake_run_path
rm -rf $mysql_run_path
rm -rf $mysql80_run_path
rm -rf /etc/my.cnf
rm -rf /etc/init.d/mysql


killall -9 nginx
boot_stop nginx
rm -rf $nginx_run_path
rm -rf /etc/init.d/nginx

rm -rf /etc/init.d/php-fpm
rm -rf $php_run_path
rm -rf $iconv_run_path

echo "卸载完成！"
}
uninstall(){
while true
do
	read -p "确认卸载整个服务器php+mysql+apache+nginx? [N/y]? " remove_all
	remove_all="`upcase_to_lowcase $remove_all`"
	case $remove_all in
	y) remove_all ; break;;
	n) break;;
	*) echo "input error";;
	esac
done
}





