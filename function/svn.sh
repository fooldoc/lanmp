#!/bin/sh

svn_install(){
#-------初始化--------
boot_stop svn
rm -rf /etc/init.d/svn
add_group svn
useradd -s /bin/bash -g svn svn -m
mkdir -p /work/svndata/conf
mkdir -p /weblog/svn
#所需包

if check_sys packageManager yum; then
	#【这个报错ubuntu无法解决,因为ubuntu找不到安装这个包，不过不影响使用好像只是不能使用http与https，先无视】
	yum install expat-devel -y
fi

#------安装--------
tar -xvf $package_dir/svn/apr-1.5.1.tar.bz2 -C $install_dir/
cd $install_dir/apr-1.5.1/
error_detect "./configure --prefix=/usr/local/apr"
error_detect "make"
error_detect "make install"
tar -xvf $package_dir/svn/apr-util-1.5.3.tar.bz2 -C $install_dir/
cd $install_dir/apr-util-1.5.3/
error_detect "./configure --prefix=/usr/local/apr --with-apr=/usr/local/apr"
error_detect "make"
error_detect "make install"

if check_sys packageManager yum;then
tar -xvf $package_dir/svn/serf-1.2.1.tar.bz2 -C $install_dir/
cd $install_dir/serf-1.2.1/
error_detect "./configure --prefix=/usr/local/serf"
error_detect "make"
error_detect "make install"
fi

tar zxvf $package_dir/svn/$svn_pag -C $install_dir/
unzip $package_dir/svn/sqlite-amalgamation-3081001.zip -d $svn_path
cd $svn_path
mv sqlite-amalgamation-3081001 sqlite-amalgamation
error_detect "./configure --prefix=${svn_run_path} --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr"
error_detect "make"
error_detect "make install"

#-----------------------配置环境变量--------------------------------
svn_bin=$svn_run_path/bin
if [ -s /etc/profile ] && grep $svn_bin /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
PATH=\
${svn_run_path}/bin:\
\$PATH
export PATH
EOF
fi

if [ -s /etc/profile ] && grep "SVN_EDITOR=/usr/bin/vim" /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
export SVN_EDITOR=/usr/bin/vim
EOF
fi

source /etc/profile
#-------------复制 配置文件----------------
\cp $svn_conf/conf/* /work/svndata/conf/
#------------注册服务设置为开机启动----------------
\cp $svn_conf/svn  /etc/init.d/svn
chmod 755 /etc/init.d/svn
boot_start "svn"

}


