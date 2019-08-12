#!/bin/sh
#初始化安装
init_install(){
#需要root权限用户
need_root_priv
#禁止selinux    
if check_sys packageManager yum; then
	disable_selinux
fi
#全局变量
load_config
}
#获取php phpize安装的so文件位置
get_php_extension_dir(){
#先匹配出该行，然后从第16个字符切割，然后去掉最后一个符号    然后转化路径增加\来转义  \/usr\/local\/php\/lib\/php\/extensions\/no-debug-non-zts-20100525    
#要将sed 赋予一个变量 要用 $(sed xxx) 包围起来
php_config_run_path=$(sed -n '/extension_dir=/p' ${php_run_path}/bin/php-config|cut -c16- |sed 's/.$//'|sed 's/[/]/\\\//g')
echo php_config_run_path路径=$php_config_run_path;
php_config_run_path_origin=$(sed -n '/extension_dir=/p' ${php_run_path}/bin/php-config|cut -c16- |sed 's/.$//')
echo php_config_run_path_origin路径=$php_config_run_path_origin;
}
#修改php.ini 扩展目录
set_php_extension_dir(){
get_php_extension_dir
#草这句命令纠结了很久。。带参数key后 需要把$! 前面加上 \ 
sed -i -r ":a;N;\$!ba;s/\;\s*extension_dir\s*=\s*\"\.\/\"/extension_dir=\"${php_config_run_path}\"/" $php_run_path/etc/php.no_disable.ini
sed -i -r ":a;N;\$!ba;s/\;\s*extension_dir\s*=\s*\"\.\/\"/extension_dir=\"${php_config_run_path}\"/" $php_run_path/etc/php.ini

}
#加载扩展so文件
set_php_extension_so(){
local key=$1
if grep -q -E "$key" $php_run_path/etc/php.ini;then
        echo "已存在$key文件"
else
#在php.ini 中 匹配到 ； extension_dir =  然后在这一行前面 加上  so扩展文件引入， shell脚本太难写了。。在匹配行之后 sed不懂怎么写 
sed -i "0,/\;\s*extension_dir/{//s/.*/extension=\"$key\"\n&/}" $php_run_path/etc/php.ini

fi

if grep -q -E "$key" $php_run_path/etc/php.no_disable.ini;then
        echo "已存在$key文件"
else
sed -i "0,/\;\s*extension_dir/{//s/.*/extension=\"$key\"\n&/}" $php_run_path/etc/php.no_disable.ini

fi

}

