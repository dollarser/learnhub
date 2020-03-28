#!/system/bin/sh
#显示监听端口(执行卡死请关闭)
SDK="off"
#脚本'Jume'资料库存放目录位置
JDIR='/system/xbin'

echo "──────────────────────────────"
echo "-----------------核心防跳状态检测反馈-------------------"
echo "──────────────────────────────"
echo "m='c'" > /data/a.conf
echo "a='$SDK'" >> /data/a.conf
chmod 777 /data/a.conf
$JDIR/Jume/Jume8
echo ""
echo ""
echo "──────────────────────────────"
echo "-----------------当前系统防火墙规则链-------------------"
echo "──────────────────────────────"

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

#---------------------------