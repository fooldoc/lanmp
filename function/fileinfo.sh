#!/bin/sh
fileinfo_install(){
tar zxvf $package_dir/$php_pag -C $install_dir/
cd "${php_path}ext/fileinfo"
${php_run_path}/bin/phpize
error_detect "./configure --with-php-config=${php_run_path}/bin/php-config"
error_detect "make" 
error_detect "make install" 
#设置扩展so的路径
set_php_extension_dir
#在php.ini中引入so扩展文件
set_php_extension_so fileinfo.so

#判断是否存在
if [ -s "${php_config_run_path_origin}/fileinfo.so" ]; then
        echo "====== fileinfo.so installed successfully,======"
        echo "安装成功，请手动重启php服务！"
else
        echo "fileinfo.so 安装失败！请将错误信息发给作者！"
fi
}
