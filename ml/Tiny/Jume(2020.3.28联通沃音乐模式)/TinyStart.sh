#!/system/bin/sh
#-------------------------------------------#
#       终极防跳8.0_By Jume       #
#-------------------------------------------#
#-----------全局代理设置-----------#
echo "#全局代理UID
UID0='3004'

#全局/直连转发IP设置
DIP='127.0.0.1'
PORT='65080'

#-----------定义本机设置-----------#
#半代理应用，多个uid用空格间隔
UID1=''

#不代理应用，多个uid用空格间隔
UID2=''

#禁联网应用，多个uid用空格间隔
UID3=''

#单放UDP应用，多个uid用空格间隔
UID4=''

#单放HTTPS应用，多个uid用空格间隔
UID5=''

#定义DNS解释IP，不填将使用默认DNS
DNSIP=''

#DNS放行，开启转发/共享电脑等需开启
FDNS='on'

#HTTPS全放行，防部分代理HTTPS不联网
FHTTPS='off'

#UDP全放行，防部分APP或网游联网问题
FXUDP='off'

#自动放行WIFI,连放行网卡关闭则代理WIFI
ZFWIFI='off'

#放行WIFI网卡名称,共享不经代理尝试留空
WIFIF='wlan0 tun0'

#指定tcp端口走回全局代理不经过模块处理
TDK=''

#本机TCP/UDP端口放行，多个用空格间隔
BTCP=''
BUDP=''

#-----------定义共享设置-----------#
#共享免设代理，关后直接共享则不经代理
GXMM='on'

#共享规则设置(A1热点/A2usb/A3特殊|B)
GXMOE='A1'

#共享DNS放行,在线视频或共享电脑须开启
GDNS='on'

#防止共享网络不经代理没问题不建议开启
FZGX='on'

#UDP放行,解决部分程序或网游等联网问题
GFUDP='off'

#HTTPS放行,全局支持HTTPS代理无需开启
GHTTPS='off'

#共享TCP/UDP端口放行，多个用空格间隔
GTCP=''
GUDP=''

#-----------其他选项设置-----------#
#执行脚本自动关开一遍网络防止QQ乱跳等
ZDKG='on'

#QQ视频代理(可拨不能接)关能但拨也不代理
QQML='on'
QUID='99999'

#设置脚本'Jume'资源库文件夹安装目录位置
JDIR='/system/xbin'

#-----------转发处理设置-----------#
#(u2nl/Hu2nl/redsocks)tcp处理/on只转端口
CHTTPS='u2nl'
CHDK='1256'

#设置(u2nl/Hu2nl/redsocks)模块转发服务器
UIP='10.0.0.172'
UDK='80'

#(dnsp/tdnsp/pdnsd)dns解释/on只转端口
MDNS='on'
MDDK='65053'

#设置pdnsd的DNS代理IP(多个IP可用','隔开)
PDNP='114.114.114.114'

#设置dnsp模块在线解释DNS时所使用的地址
DNSP='www.fuchenmz.cn/nslookup.php'

#设置tdnsp模块在线解释DNS时所使用的地址
TDNSPP='http://119.29.29.29'

#设置tdns模块在线解释DNS时所使用的地址,只支持php或127.0.0.1
TDNSS='http://www.fuchenmz.cn/nslookup.php'

#---------以下内容切勿修改--------#
BY='Jume'
#-----------启动终极v8.0-----------#
" > /data/Jume8.conf
chmod 777 /data/Jume8.conf
echo "m='a'" > /data/a.conf
chmod 777 /data/a.conf
. /data/Jume8.conf
$JDIR/Jume/Jume8
#-------------------完毕-------------------#
#以下为自定义脚本:

#-------------------------------------------#