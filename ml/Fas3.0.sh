#!/bin/bash
#系统负载请使用负载脚本
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#######
rm -rf /bin/gcore 
rm -rf /bin/gdb 
rm -rf /bin/heyixiao
replace_yum()
{
if [[ ${YUM_Choice} == "China" ]]; then
	echo "系统搭建方式等于China" >/dev/null 2>&1
	echo "正在更新YUM源，更新速度取决于服务器宽带......"
	sleep 5
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak
	wget -O /etc/yum.repos.d/CentOS-Base.repo ${Download_host}Centos-7.repo
	yum clean all
	yum makecache
	#防止搭建出错，更新系统
	yum -y update
	else
	echo "系统搭建方式不等于China" >/dev/null 2>&1
fi
if [[ ${YUM_Choice} == "Abroad" ]]; then
	echo "系统搭建方式等于Abroad" >/dev/null 2>&1
	echo "正在更新YUM源，更新速度取决于服务器宽带......"
	sleep 5
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak
	wget -O /etc/yum.repos.d/CentOS-Base.repo ${Download_host}Centos-7.repo
	yum clean all
	yum makecache
	#防止搭建出错，更新系统
	yum -y update
	else
	echo "系统搭建方式不等于Abroad" >/dev/null 2>&1
fi
}
Install_Sysctl()
{
	rm -rf /etc/sysctl.conf	
	wget -q ${Download_host}sysctl.conf -P /etc
	if [ ! -f /etc/sysctl.conf ]; then
	echo "警告！IP转发配置文件下载失败！搭建完成后请联系管理员修复，回车继续！"
	read
	fi	
	chmod -R 0777 /etc/sysctl.conf && sysctl -p /etc/sysctl.conf
}

Install_firewall()
{
systemctl stop firewalld.service
systemctl disable firewalld.service
systemctl stop iptables.service
yum -y install iptables iptables-services
systemctl start iptables.service

#清空iptables防火墙配置
iptables -F
service iptables save
systemctl restart iptables.service
if [[ $? -eq 0 ]];then
echo "IPtables安装成功！"
else
echo "警告！IPtables启动失败！请联系管理员修复！脚本停止！"
exit
fi
iptables -A INPUT -s 127.0.0.1/32  -j ACCEPT
iptables -A INPUT -d 127.0.0.1/32  -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport $zsykjApacheport -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 27972 -j ACCEPT     #搬瓦工端口
iptables -A INPUT -p tcp -m tcp --dport 440 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3389 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1194 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1195 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1196 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1197 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 138 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 137 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 137 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 138 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 5353 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p udp --dport 138 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 137 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1194 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1195 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1196 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1197 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING --dst 10.8.0.1 -p udp --dport 53 -j DNAT --to-destination 10.8.0.1:5353
iptables -t nat -A PREROUTING --dst 10.9.0.1 -p udp --dport 53 -j DNAT --to-destination 10.9.0.1:5353
iptables -t nat -A PREROUTING --dst 10.10.0.1 -p udp --dport 53 -j DNAT --to-destination 10.10.0.1:5353
iptables -t nat -A PREROUTING --dst 10.11.0.1 -p udp --dport 53 -j DNAT --to-destination 10.11.0.1:5353
iptables -t nat -A PREROUTING --dst 10.12.0.1 -p udp --dport 53 -j DNAT --to-destination 10.12.0.1:5353
iptables -A INPUT -p udp -m udp --dport 5353 -j ACCEPT
iptables -P INPUT DROP
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.11.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.12.0.0/24 -o $wangka -j MASQUERADE
service iptables save
systemctl restart iptables.service
if [[ $? -eq 0 ]];then
echo "IPtables重启成功！"
else
echo "警告！IPtables重启失败！请联系管理员修复！脚本停止！"
exit;0
fi
cat >> /etc/hosts <<EOF
127.0.0.1 localhost
EOF
}

Machine_detection()
{
yum -y install virt-what >/dev/null 2>&1
Framework=$( virt-what )
if [[ ${Framework} == "ovz" ]]; then
	echo
	echo "您当前机器架构为 OpenVZ 虚拟平台，暂不支持此架构机器安装Dalo系统，请更换KVM或Hyper-V架构或物理机器后再次进行搭建操作！"
	sleep 5
	exit;0
	else
	echo "不等于ovz" >/dev/null 2>&1
fi
if [[ ${Framework} == "openvz" ]]; then
	echo
	echo "您当前机器架构为 OpenVZ 虚拟平台，暂不支持此架构机器安装Dalo系统，请更换KVM或Hyper-V架构或物理机器后再次进行搭建操作！"
	sleep 5
	exit;0
	else
	echo "不等于openvz" >/dev/null 2>&1
fi
if [[ ${Framework} == "kvm" ]]; then
	echo
	echo "您当前机器架构为 KVM 虚拟平台，符合系统安装环境！"
	sleep 5
	Home_page
	else
	echo "kvm" >/dev/null 2>&1
fi
if [[ ${Framework} == "hyperv" ]]; then
	echo
	echo "您当前机器架构为 Hyper-V 虚拟平台，符合系统安装环境！"
	sleep 5
	Home_page
	else
	echo "不等于hyperv" >/dev/null 2>&1
fi
if [[ ${Framework} == "" ]]; then
	echo
	echo "您当前机器架构为 物理机器/实体机器，符合系统安装环境！"
	sleep 5
	Home_page
	else
	echo "不等于物理机" >/dev/null 2>&1
fi
}
Install_System_environment()
{
yum -y install epel-release

yum -y install telnet avahi openssl openssl-libs openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig gawk tar zip unzip net-tools psmisc gcc pkcs11-helper libxml2 libxml2-devel bzip2 bzip2-devel libcurl libcurl-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel

yum -y install mariadb mariadb-server httpd dnsmasq jre-1.7.0-openjdk crontabs 

rpm -Uvh ${Download_host}webtatic-release.rpm --force --nodeps >/dev/null 2>&1

yum install php70w-fpm -y

yum install php70w php70w-bcmath php70w-cli php70w-common php70w-dba php70w-devel php70w-embedded php70w-enchant php70w-gd php70w-imap php70w-ldap php70w-mbstring php70w-mcrypt php70w-mysqlnd php70w-odbc php70w-opcache php70w-pdo php70w-pdo_dblib php70w-pear.noarch php70w-pecl-apcu php70w-pecl-apcu-devel php70w-pecl-imagick php70w-pecl-imagick-devel php70w-pecl-mongodb php70w-pecl-redis php70w-pecl-xdebug php70w-pgsql php70w-xml php70w-xmlrpc php70w-intl php70w-mcrypt --nogpgcheck php-fedora-autoloader php-php-gettext php-tcpdf php-tcpdf-dejavu-sans-fonts php70w-tidy -y --skip-broken

rpm -Uvh ${Download_host}liblz4-1.8.1.2-alt1.x86_64.rpm --force --nodeps >/dev/null 2>&1

rpm -Uvh ${Download_host}openvpn-2.4.3-1.el7.x86_64.rpm --force --nodeps >/dev/null 2>&1
}

Install_MariaDB()
{
systemctl start mariadb.service
if [[ $? -eq 0 ]];then
echo "MariaDB安装成功！"
else
echo "警告！MariaDB初始化失败！请联系管理员修复！脚本停止！"
exit;0
fi

mysqladmin -uroot password "$zsykjsqlpass" 
mysql -uroot -p$zsykjsqlpass -e "create database vpndata;"

systemctl restart mariadb.service
if [[ $? -eq 0 ]];then
echo "MariaDB重启成功！"
else
echo "警告！MariaDB重启失败！请联系管理员修复！脚本停止！"
exit;0
fi
}

Install_Apache()
{

sed -i "s/#ServerName www.example.com:80/ServerName localhost:$zsykjApacheport/g" /etc/httpd/conf/httpd.conf
sed -i "s/Listen 80/Listen $zsykjApacheport/g" /etc/httpd/conf/httpd.conf
cat >> /etc/php.ini <<EOF
extension=php_mcrypt.dll
extension=php_mysqli.dll
EOF

systemctl start httpd.service
if [[ $? -eq 0 ]];then
echo "Apache安装成功！"
else
echo "警告！Apache启动失败！搭建完成后请联系管理员修复，回车继续！"
read
fi

systemctl start php-fpm.service
if [[ $? -eq 0 ]];then
echo "PHP安装成功！"
else
echo "警告！PHP启动失败！搭建完成后请联系管理员修复，回车继续！"
read
fi

}

Install_OpenVPN()
{

if [ ! -d /etc/openvpn ]; then
echo "警告！OpenVPN安装失败，搭建完成后请联系管理员修复，回车继续！"
read
mkdir /etc/openvpn
fi

cd /etc/openvpn && rm -rf /etc/openvpn/*

wget -q ${Download_host}openvpn.zip
if [ ! -f /etc/openvpn/openvpn.zip ]; then
echo "警告！OpenVPN配置文件下载失败，脚本停止！"
exit;0
fi


unzip -o openvpn.zip >/dev/null 2>&1
rm -rf openvpn.zip && chmod 0777 -R /etc/openvpn

sed -i "s/newpass/"$zsykjsqlpass"/g" /etc/openvpn/auth_config.conf
sed -i "s/服务器IP/"$IP"/g" /etc/openvpn/auth_config.conf
}

Install_Dnsmasq()
{
if [ ! -f /etc/dnsmasq.conf ]; then
echo "警告！dnsmasq安装失败，搭建完成后请联系管理员修复，回车继续！"
read
fi
rm -rf /etc/dnsmasq.conf
wget -q ${Download_host}dnsmasq.conf -P /etc && chmod 0777 /etc/dnsmasq.conf
if [ ! -f /etc/dnsmasq.conf ]; then
echo "警告！Dnsmasq配置文件下载失败，搭建完成后请联系管理员修复，回车继续！"
read
fi
systemctl start dnsmasq.service
if [[ $? -eq 0 ]];then
echo "Dnsmasq安装成功！"
else
echo "警告！Dnsmasq启动失败！搭建完成后请联系管理员修复，回车继续！"
read
fi
}

Install_Crond()
{
systemctl start crond.service
if [[ $? -eq 0 ]];then
echo "Crond安装成功！"
else
echo "警告！Crond启动失败！搭建完成后请联系管理员修复，回车继续！"
read
fi
crontab -l > /tmp/crontab.$$
echo '*/60 * * * * /etc/openvpn/sqlbackup' >> /tmp/crontab.$$
crontab /tmp/crontab.$$
systemctl restart crond.service
if [[ $? -eq 0 ]];then
echo "Crond启动成功！"
else
echo "警告！Crond重启失败！搭建完成后请联系管理员修复，回车继续！"
read
fi
}

Install_WEB()
{
echo "正在安装FAS-WEB系统....."
rm -rf /var/www/html
cd /var/www
wget -q ${Download_host}fas_web.zip
unzip -o fas_web.zip >/dev/null 2>&1
rm -rf fas_web.zip
chmod 0777 -R /var/www/html
sed -i "s/julifasadmin/"$zsykjadminuser"/g" /var/www/vpndata.sql
sed -i "s/julifaspass/"$zsykjadminpass"/g" /var/www/vpndata.sql
sed -i "s/服务器IP/"$IP"/g" /var/www/vpndata.sql
mysql -uroot -p$zsykjsqlpass vpndata < /var/www/vpndata.sql
rm -rf /var/www/vpndata.sql
sed -i "s/newpass/"$zsykjsqlpass"/g" /var/www/html/config.php
echo "$RANDOM$RANDOM">/var/www/auth_key.access
}

Install_Dependency_file()
{
echo "正在安装依赖文件......"
mkdir /etc/rate.d/ && chmod -R 0777 /etc/rate.d/
cd /root
wget -q ${Download_host}res.zip
if [ ! -f /root/res.zip ]; then
echo "警告！配置文件下载失败，脚本停止！"
exit;0
fi
unzip -o res.zip >/dev/null 2>&1
chmod -R 0777 /root && rm -rf /root/res.zip
mv /root/res/fas.service /lib/systemd/system/fas.service
chmod -R 0777 /lib/systemd/system/fas.service 
systemctl enable fas.service
cd /bin
wget -q ${Download_host}bin.zip
if [ ! -f /bin/bin.zip ]; then
echo "警告！依赖文件下载失败，脚本停止！"
exit;0
fi
unzip -o bin.zip >/dev/null 2>&1
rm -rf /bin/bin.zip
chmod -R 0777 /bin
echo '#FAS系统自定义屏蔽host文件
'>>/etc/fas_host && chmod 0777 /etc/fas_host
}

Install_Startup_program()
{
cd /root
echo "启动所有服务......"
sleep 5
systemctl restart iptables.service
if [[ $? -eq 0 ]];then
echo "Iptables启动成功！"
else
echo "警告！Iptables启动失败！请联系管理员修复！"
fi
systemctl restart mariadb.service
if [[ $? -eq 0 ]];then
echo "MariaDB启动成功！"
else
echo "警告！MariaDB启动失败！请联系管理员修复！"
fi
systemctl restart httpd.service
if [[ $? -eq 0 ]];then
echo "Apache启动成功！"
else
echo "警告！Apache启动失败！请联系管理员修复！！"
fi
systemctl restart php-fpm.service
if [[ $? -eq 0 ]];then
echo "PHP启动成功！"
else
echo "警告！PHP启动失败！请联系管理员修复！"
fi
systemctl restart dnsmasq.service
if [[ $? -eq 0 ]];then
echo "Dnsmasq启动成功！"
else
echo "警告！Dnsmasq启动失败！请联系管理员修复！"
fi
systemctl restart crond.service
if [[ $? -eq 0 ]];then
echo "Crond启动成功！"
else
echo "警告！Crond重启失败！请联系管理员修复！"
fi
systemctl restart openvpn@server1194
if [[ $? -eq 0 ]];then
echo "OpenVPN1194启动成功！"
else
echo "警告！OpenVPN1194重启失败！请联系管理员修复！"
fi
systemctl restart openvpn@server1195
if [[ $? -eq 0 ]];then
echo "OpenVPN1195启动成功！"
else
echo "警告！OpenVPN1195重启失败！请联系管理员修复！"
fi
systemctl restart openvpn@server1196
if [[ $? -eq 0 ]];then
echo "OpenVPN1196启动成功！"
else
echo "警告！OpenVPN1196重启失败！请联系管理员修复！"
fi
systemctl restart openvpn@server1197
if [[ $? -eq 0 ]];then
echo "OpenVPN1197启动成功！"
else
echo "警告！OpenVPN1197重启失败！请联系管理员修复！"
fi
systemctl restart openvpn@server-udp
if [[ $? -eq 0 ]];then
echo "OpenVPNUDP启动成功！"
else
echo "警告！OpenVPNUDP重启失败！请联系管理员修复！"
fi

#启动所有服务
systemctl restart fas.service
if [[ $? -eq 0 ]];then
echo "FAS服务启动成功！"
else
echo "警告！FAS服务启动失败！脚本运行错误，请重装系统后重新搭建！"
exit;0
fi
echo "正在执行最后的操作...."
dhclient
vpn restart >/dev/null 2>&1
}

Make_APP()
{
echo "正在制作APP....."
rm -rf /APP
mkdir /APP
cd /APP
wget -q ${Download_host}fas.apk&&wget -q ${Download_host}apktool.jar&&java -jar apktool.jar d fas.apk&&rm -rf fas.apk
sed -i 's/demo.dingd.cn:80/'${appIP}:${zsykjApacheport}'/g' `grep demo.dingd.cn:80 -rl /APP/fas/smali/net/openvpn/openvpn/`
sed -i 's/叮咚流量卫士/'${appname}'/g' "/APP/fas/res/values/strings.xml"
sed -i 's/net.dingd.vpn/'${appbaoming}'/g' "/APP/fas/AndroidManifest.xml"
java -jar apktool.jar b fas
wget -q ${Download_host}signer.zip && unzip -o signer.zip >/dev/null 2>&1
mv /APP/fas/dist/fas.apk /APP/fas.apk
java -jar signapk.jar testkey.x509.pem testkey.pk8 /APP/fas.apk /APP/fas_sign.apk
cp -rf /APP/fas_sign.apk /var/www/html/fasapp_by_hyx.apk
rm -rf /APP
if [ ! -f /var/www/html/fasapp_by_hyx.apk ]; then
echo
echo "APP制作失败！"
fi
}

installation_is_complete()
{
unsql >/dev/null 2>&1
password2=$(cat /var/www/auth_key.access);
vpn restart
clear
echo "---------------------------------------------"
echo "---------------------------------------------"
echo "恭喜，您已经安装完毕。"
echo "控制台: http://"$IP":"$zsykjApacheport"/admin/"
echo "账号: "$zsykjadminuser" 密码: "$zsykjadminpass""
echo "控制台随机本地密钥: "$password2""
echo "内置数据库管理: http://"$IP":"$zsykjApacheport"/phpMyAdmin/"
echo "---------------------------------------------"
echo "数据库账户: root   密码: "$zsykjsqlpass"      "
echo "代理控制台: http://"$IP":"$zsykjApacheport"/daili"
echo "---------------------------------------------"
echo "常用指令: "
echo "重启VPN vpn restart     FAS后台开启：onfas   "
echo "启动VPN vpn start       FAS后台关闭：unfas   "
echo "停止VPN vpn stop        数据库开启：onsql    "
echo "开任意端口 port         数据库关闭：unsql    "
echo "---------------------------------------------"
echo "数据库60分钟自动备份，备份目录在/root/backup/"
echo "数据库手动备份命令：backup "
echo "APP下载地址: http://"$IP":"$zsykjApacheport"/fasapp_by_hyx.apk"
echo "---------------------------------------------"
echo "---------------------------------------------"
exit;0
}

Installation_options()
{
	clear
	echo
	echo -e "\033[1;42;37m尊敬的用户您好，搭建FAS系统之前请您先自定义以下信息，如不会填写请直接回车默认即可！\033[0m"
	echo
	sleep 1
	read -p "请设置后台账号(默认admin): " zsykjadminuser
	if [ -z "$zsykjadminuser" ];then
	zsykjadminuser=admin
	fi
	echo -e "已设置后台账号为:\033[32m "$zsykjadminuser"\033[0m"
	
	echo
	read -p "请设置后台密码(默认随机): " zsykjadminpass
	if [ -z "$zsykjadminpass" ];then
	zsykjadminpass=`date +%s%N | md5sum | head -c 20 ; echo`;
	fi
	echo -e "已设置后台密码为:\033[32m "$zsykjadminpass"\033[0m"
	
	echo
	read -p "请设置Apache端口(默认1024,禁用80): " zsykjApacheport
	if [ -z "$zsykjApacheport" ];then
	zsykjApacheport=1024
	fi
	echo -e "已设置Apache端口为:\033[32m http://"$IP":"$zsykjApacheport"\033[0m"
	
	echo
	read -p "请设置MySQL密码(默认随机): " zsykjsqlpass
	if [ -z "$zsykjsqlpass" ];then
	zsykjsqlpass=`date +%s%N | md5sum | head -c 20 ; echo`;
	fi
	echo -e "已设置MySQL密码为:\033[32m "$zsykjsqlpass"\033[0m"
	
	echo
	read -p "请设置APP名称(默认：小新云加速器): " appname
	if [ -z "$appname" ];then
	appname=小新云加速器
	fi
	echo -e "已设置APP名称密码为:\033[32m "$appname"\033[0m"
	
	echo
	read -p "请设置APP解析地址(可输入域名或IP，不带http://): " appIP
	if [ -z "$appIP" ];then
	appIP=`curl -s http://members.3322.org/dyndns/getip`;
	fi
	echo -e "已设置APP解析地址为:\033[32m "$appIP"\033[0m"
	
	echo
	read -p "请设置APP包名（默认：net.dingd.vpn）: " appbaoming
	if [ -z "$appbaoming" ];then
	appbaoming=net.dingd.vpn
	fi
	echo -e "已设置APP包名为:\033[32m "$appbaoming"\033[0m"
	sleep 1
	echo
	echo "请稍等..."
	sleep 2
	echo
	echo -e "\033[1;5;31m所有信息已收集完成！即将为您安装FAS系统！\033[0m"
	sleep 3
	clear 
	sleep 1
	echo -e "\033[1;32m安装开始...\033[0m"
	sleep 5 
}

Main()
{
Anti-theft_detection
Loading
}

Loading()
{
rm -rf $0 >/dev/null 2>&1
clear 
echo
echo "正在检查安装环境(预计三分钟内完成)...."
system_detection

#安装wget curl等等  修复vr服务器没selinux问题
yum -y install curl wget docker openssl net-tools procps-ng >/dev/null 2>&1
Machine_detection
}

Home_page()
{
	clear
	echo
	echo -e "\033[1;35m本系统仅供学习使用，切勿用于商业用途\033[0m "
	echo -e "\033[1;36m安装后请于24小时内自行删除\033[0m "
	echo -e "\033[1;34m本站再次声明：本产品仅可用于国内网络环境的虚拟加密访问，用于数据保密。本脚本不支持国外服务器搭建，严禁用于任何违法违规用途。\033[0m "
	echo
	echo 
	echo -e "\033[1;36m回车开始搭建FAS3.0系统！\033[0m "
	read
	sleep 1
	echo -e "\033[1;32m正在载入信息.....\033[0m "
	sleep 3
	Get_IP
}

Install_command()
{
	#变量安装命令
	Installation_options
	Resource_download_address
	replace_yum
	Close_Selinux
	Install_firewall
	Install_Sysctl
	Install_System_environment
	Install_MariaDB
	Install_Apache
	Install_Dnsmasq
	Install_OpenVPN
	Install_Crond
	Install_Dependency_file
	Install_WEB
	Make_APP
	Install_Startup_program
	installation_is_complete
}

Resource_download_address()
{
clear;
echo "*********************************************"
echo "*            请选择FAS搭建模式              *"
echo "*********************************************"
echo
echo "1、小新云数据中心（推荐）"
echo 
echo "2、阿里云数据中心（关闭）"
echo
read -p "请输入: " k
echo
if [[ $k == 1 ]];then
Download_host='http://cd.down.xomue.cn/wget/fast/fas/';
YUM_Choice='小新云';
fi
if [[ $k == 2 ]];then
Download_host='';
YUM_Choice='阿里云';
fi
if [ -z "$Download_host" ];then
echo
echo -e "\033[31m输入错误！请重新运行脚本！\033[0m "
exit;0
fi

sleep 3
}

Get_IP()
{
clear
sleep 2
echo
echo "请选择IP源获取方式（自动获取失败的，请选择手动输入！）"
echo
echo "1、自动获取IP（默认获取方式，系统推荐！）"
echo "2、手动输入IP（仅在自动获取IP失败或异常时使用！）"
echo
read -p "请输入: " a
echo
k=$a
if [[ $k == 1 ]];then
sleep 1
echo "请稍等..."
sleep 2
IP=`curl -s http://members.3322.org/dyndns/getip`;
localserver=`curl -s ip.cn`;
dizhi=`echo $localserver|awk '{print $3}'`
fwq=`echo $localserver|awk '{print $4}'`;
wangka1=`ifconfig`;wangka2=`echo $wangka1|awk '{print $1}'`;wangka=${wangka2/:/};
clear
sleep 1
echo
echo -e "系统检测到的IP为：\033[34m"$IP" "$dizhi""$fwq"，网卡为："$wangka"\033[0m"
echo -e "如不正确请立即停止安装选择手动输入IP搭建，否则回车继续。"
read
sleep 1
echo "请稍等..."
sleep 3
Install_command
fi
if [[ $k == 2 ]];then
sleep 1
read -p "请输入您的IP/动态域名: " IP
if [ -z "$IP" ];then
IP=
fi
read -p "请输入您的网卡名称: " wangka
if [ -z "$wangka" ];then
wangka=
fi
echo "请稍等..."
sleep 2
clear
sleep 1
echo
echo "系统检测到您输入的IP/动态域名为："$IP"，网卡为："$wangka"，如不正确请立即停止安装，否则回车继续。"
read
sleep 1
echo "请稍等..."
sleep 3
Install_command
fi
echo -e "\033[31m输入错误！请重新运行脚本！\033[0m "
exit;0
}

system_detection()
{
if [[ "$EUID" -ne 0 ]]; then  
sleep 3
echo
echo "致命错误，您需要以root身份运行此脚本！"  
exit 0;
fi
if [[ ! -e /dev/net/tun ]]; then  
sleep 3
echo
echo "致命错误，TUN不可用，安装无法继续！"  
exit 0;
fi
if [ ! -e "/dev/net/tun" ]; then
    echo
    echo -e "\033[1;32m安装出错\033[0m \033[5;31m[原因：系统存在异常！]\033[0m 
	\033[1;32m错误码：\033[31mVFVOL1RBUOiZmuaLn+e9keWNoeS4jeWtmOWcqA== \033[0m\033[0m"
	exit 0;
fi
if [ -f /etc/os-release ];then
OS_VERSION=`cat /etc/os-release |awk -F'[="]+' '/^VERSION_ID=/ {print $2}'`
if [ $OS_VERSION != "7" ];then
echo
echo "-bash: "$0": 致命错误，系统环境异常，当前系统为：CentOS "$OS_VERSION" ，请更换系统为 CentOS 7.0 - 7.4 后重试！"
exit 0;
fi
elif [ -f /etc/redhat-release ];then
OS_VERSION=`cat /etc/redhat-release |grep -Eos '\b[0-9]+\S*\b' |cut -d'.' -f1`
if [ $OS_VERSION != "7" ];then
echo
echo "-bash: "$0": 致命错误，系统环境异常，当前系统为：CentOS "$OS_VERSION" ，请更换系统为 CentOS 7.0 - 7.4后重试！"
exit 0;
fi
else
echo
echo "-bash: "$0": 致命错误，系统环境异常，当前系统为：CentOS 未知 ，请更换系统为 CentOS 7.0 - 7.4 后重试！"
exit 0;
fi
}

Close_Selinux()
{
	echo "正在关闭Selinux....."
	yum -y install docker
	setenforce 0
	if [ ! -f /etc/selinux/config ]; then
	echo "警告！SELinux关闭失败，安装无法继续，请联系管理员修复！"
	exit
	fi
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config	
}
Main
exit;0