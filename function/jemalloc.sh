#!/bin/sh
jemalloc_install(){
#lsof -n | grep jemalloc 查看
rm -rf $jemalloc_run_path
tar xjf $package_dir/$jemalloc_pag -C $install_dir/
cd $jemalloc_path
error_detect "./configure"
error_detect "make" 
error_detect "make install"

if [ -s /etc/ld.so.conf.d/local.conf ] && grep "/usr/local/lib" /etc/ld.so.conf.d/local.conf;then
echo 'has'
else
cat>>/etc/ld.so.conf.d/local.conf<<EOF
/usr/local/lib
EOF
fi
/sbin/ldconfig
ln -s /usr/local/lib/libjemalloc.so /usr/lib/libjemalloc.so
}
