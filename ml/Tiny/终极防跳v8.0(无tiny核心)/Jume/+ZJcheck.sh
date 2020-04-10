#!/system/bin/sh
#--------------------------
#显示监听端口(执行卡死请关闭)
SDK="off"
#脚本'Jume'资料库存放目录位置
JDIR='/system/xbin'
#--------------------------
echo "m='c'" > /data/a.conf
echo "a='$SDK'" >> /data/a.conf
chmod 777 /data/a.conf
$JDIR/Jume/Jume8
echo "---------------------"
echo "当前NAT表防火墙规则："
echo "---------------------"
iptables -nL -t nat --line-number
echo " "
echo "---------------------"
echo "当前Mangle表防火墙规则："
echo "---------------------"
iptables -nL -t mangle --line-number
#--------------------------
#以下为自定义脚本:
echo "---------------------"
if [[ `ps|grep tiny|grep -v grep` != "" ]]
then  echo "o tiny 已运行"
else echo "x tiny未运行";fi
#--------------------------