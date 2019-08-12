#!/bin/sh
#===============================================================================
#   SYSTEM REQUIRED:  Linux
#   DESCRIPTION:  php+apache+nginx+mysql
#   AUTHOR: fooldoc
#   EMAIL: 949477774@qq.com	
#   time:2015-05-16
#===============================================================================
cur_dir=`pwd`
MemTotal=`free -m | grep Mem | awk '{print  $2}'`
package_dir=$cur_dir/package
install_dir=$cur_dir/install_pag
conf_dir=$cur_dir/conf
#载入函数
load_functions(){
	local function=$1
	if [[ -s $cur_dir/function/${function}.sh ]];then
		. $cur_dir/function/${function}.sh
	else
		echo "$cur_dir/function/${function}.sh not found,shell can not be executed."
		exit 1
	fi	
}
#配置linux
main(){
#开始载入
load_functions path
load_functions public
load_functions init
load_functions init_web
load_functions mysql
load_functions apache
load_functions nginx
load_functions php
load_functions uninstall
load_functions svn
load_functions memcached
load_functions jemalloc
load_functions fileinfo
load_functions redis
load_functions imagick
clear
echo "#############################################################################"
echo 
echo "SYSTEM REQUIRED:  Linux"
echo "DESCRIPTION:  php+apache+nginx+mysql"
echo "AUTHOR: fooldoc"
echo "EMAIL:949477774@qq.com"
echo "time:2015-05-16"
echo "博客：http://www.fooldoc.com"
echo "note:本脚使用兼容处理方式，支持各种重复执行安装！"
echo "warning:如安装失败请将/tmp/fooldoc_fwq.log文件发予作者"
echo
echo "############################################################################"
echo
#初始化配置
init_install

#菜单
memu_index
}
#菜单扩展选项
memu_php(){
echo "#############################################################################"
echo
echo "是否安装php,fileinfo扩展，请注意查看自己的内存是否大于1G，如果没有请不要安装fileinfo扩展，否则编译报错"
echo
echo "############################################################################"
echo "1) 安装fileinfo"
echo "2) 不安装"
read menu_select2
case $menu_select2 in
1)
	option_php_config="--enable-fileinfo"
	;;
2)
	option_php_config="--disable-fileinfo"
        ;;
esac
}

#菜单
memu_index(){
echo "#############################################################################"
echo
echo "请选择要执行的操作"
echo
echo "####注意#####"
echo "运行脚本前请先到百度网盘下载安装包地址："
echo "https://pan.baidu.com/s/1L95Q-KOl_i0xy6e39QnKHw"
echo "下载完解压到package目录下然后在执行该脚本"
echo "############################################################################"
echo "1) 一键：php+nginx+apache+mysql+jemalloc(php5.6+mysql5.6)"
echo "2) 单个安装各种软件：php、nginx、apache、mysql"
echo "3) 安装全部依赖包"
echo "4) 安装SVN"
echo "5) 安装memcached"
echo "6) 安装jemalloc"
echo "7) 安装最新版php扩展fileinfo"
echo "8) 安装redis"
echo "9) 完全卸载php+nginx+apache+mysql"
echo "10) 安装Imagick"
echo "11) 一键：php+nginx+apache+mysql+jemalloc(php7.3+mysql8.0)"
echo "12) 一键：php+nginx+apache+mysql+jemalloc(php5.4+mysql5.6)"
read menu_select
case $menu_select in
1)
	memu_php
	init_web_install
	jemalloc_install
	mysql_install
	apache_install 2
	nginx_install
	php_install
	echo "恭喜您！顺利安装完成！如有疑问请联系【作者fooldoc】"
	;;
2)
	memu_index2
        ;;
3)
	init_web_install
        ;;
4)
	svn_install
        ;;
5)
	memcached_install
	echo "安装完成请将.so文件配置到php.ini中[可以搜索extension_dir设置dir,及extension=\"memcached.so\"]，并重启php生效,如果已安装过重新安装，请手动删除原来的.so文件在运行！"
	echo "注意如果有错误提示请反馈问题！"
        ;;
6)
	jemalloc_install
        ;;
7)
	fileinfo_install
        ;;
8)
	redis_install
        ;;
9)
	uninstall
        ;;
10)
    imagick_install
        ;;
11)
    memu_php
   	init_web_install
   	jemalloc_install
   	mysql_install_80
   	apache_install 1
   	nginx_install
   	php73_install
   	echo "恭喜您！顺利安装完成！如有疑问请联系【作者fooldoc】"
   	;;
12)
	memu_php
	init_web_install
	jemalloc_install
	mysql_install
	apache_install 2
	nginx_install
	php54_install
	echo "恭喜您！顺利安装完成！如有疑问请联系【作者fooldoc】"
	;;
esac
}

#菜单2
memu_index2(){
echo "#############################################################################"
echo
echo "请选择要执行的操作【注意单个安装请确认是否已经安装过各自依赖包！如果没有请返回主菜单选择“3”】"
echo
echo "############################################################################"
echo "1) 安装mysql"
echo "2) 安装apache"
echo "3) 安装nginx"
echo "4) 安装php"
echo "99) 返回主菜单"
read menu_select2
case $menu_select2 in
1)
	memu_mysql
	;;
2)
	memu_apache_select
        ;;
3)
	nginx_install
        ;;
4)
	memu_php
	memu_php_select
        ;;
99)
	memu_index
        ;;
esac
}

memu_mysql(){
echo "#############################################################################"
echo
echo "请选择要执行的操作【注意单个安装请确认是否已经安装过各自依赖包！如果没有请返回主菜单选择“3”】"
echo
echo "############################################################################"
echo "1) 安装mysql5.6"
echo "2) 安装mysql8.0.11"
echo "99) 返回上一级菜单"
read memu_mysql_select
case $memu_mysql_select in
1)
	mysql_install
	;;
2)
	mysql_install_80
        ;;
99)
	memu_index2
        ;;
esac
}

memu_apache_select(){
echo "#############################################################################"
echo
echo "请选择要执行的操作【注意单个安装请确认是否已经安装过各自依赖包！如果没有请返回主菜单选择“3”】"
echo
echo "############################################################################"
echo "1) 安装apache2.2"
echo "2) 安装apache2.4+php7"
echo "2) 安装apache2.4+php5"
echo "99) 返回上一级菜单"
read memu_apache_select_select
case $memu_apache_select_select in
1)
	apache_install2_2
	;;
2)
	apache_install 1
        ;;
3)
	apache_install 2
        ;;
99)
	memu_index2
        ;;
esac
}

memu_php_select(){
echo "#############################################################################"
echo
echo "请选择要执行的操作【注意单个安装请确认是否已经安装过各自依赖包！如果没有请返回主菜单选择“3”】"
echo
echo "############################################################################"
echo "1) 安装php5.6"
echo "2) 安装php7.3.3"
echo "3) 安装php5.4"
echo "99) 返回上一级菜单"
read memu_php_select_select
case $memu_php_select_select in
1)
	php_install
	;;
2)
	php73_install
        ;;
3)
	php54_install
        ;;
99)
	memu_index2
        ;;
esac
}



########从这里开始运行程序######
#rm -rf /tmp/fooldoc_fwq.log
rm -rf $install_dir/*
mkdir -p $install_dir
chmod 777 -R $cur_dir
main 2>&1 | tee -a /tmp/fooldoc_fwq.log




