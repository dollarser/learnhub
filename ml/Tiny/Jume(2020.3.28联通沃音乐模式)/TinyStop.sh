#!/system/bin/sh
#--------------------------
#关闭防跳自动关闭网络
GW='on'
#脚本'Jume'资料库存放目录位置
JDIR='/system/xbin'
#--------------------------
iptables -t nat -F OUTPUT
iptables -t mangle -F OUTPUT
iptables -t nat -F PREROUTING
echo "m='b'" > /data/a.conf
echo "a='$GW'" >> /data/a.conf
chmod 777 /data/a.conf
$JDIR/Jume/Jume8
#---------------------------
#以下为自定义脚本: 

#----------------------------