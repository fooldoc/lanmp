#!/bin/sh
imagick_install(){

if check_sys packageManager apt;then
   	apt-get update
   	apt-get install libmagickwand-dev -y
   	apt-get install libwebp-dev -y
elif check_sys packageManager yum; then
	#yum install ImageMagick-devel
	yum install　libwebp　-y
	yum install　libwebp-devel -y
fi

tar zxvf $package_dir/ImageMagick-7.0.7-23.tar.gz -C $install_dir/
cd "${install_dir}/ImageMagick-7.0.7-23/"
error_detect "./configure --prefix=/usr/local/imagemagick --with-webp"
error_detect "make"
error_detect "make install"

tar zxvf $package_dir/imagick-3.4.3.tgz -C $install_dir/
cd "${install_dir}/imagick-3.4.3/"
${php_run_path}/bin/phpize
error_detect "./configure --with-php-config=${php_run_path}/bin/php-config --with-imagick=/usr/local/imagemagick"
error_detect "make"
error_detect "make install"

#设置扩展so的路径
set_php_extension_dir
#在php.ini中引入so扩展文件
set_php_extension_so imagick.so

#判断是否存在
if [ -s "${php_config_run_path_origin}/imagick.so" ]; then
        echo "====== imagick.so installed successfully,======"
        echo "安装成功，请手动重启php服务！"
else
        echo "imagick.so 安装失败！请将错误信息发给作者！"
fi
}
