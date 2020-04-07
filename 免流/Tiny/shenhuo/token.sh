#!/system/bin/sh
get_token(){
echo "❁ 正在获取动态验证..."

#读取配置文件接口，注释默认接口
#token_api='http://cs.xxzml.cn/k/get_tinyproxy_config.php'

#通过接口获取token
if [ "$token_api" != "" ];then
rm -rf ./cache
./wget $token_api -O ./cache &>/dev/null
echo "获取动态验证成功"

#优化代码
else
echo "动态接口失效，请更换接口"

: '注释
echo "测试一下多行注释的两种方式，单引号和感叹号"
:<<!
注释掉本地获取token的代码，因为米粉卡没有qq浏览器定向
!
input keyevent 224
am start -n com.tencent.mtt/com.tencent.mtt.SplashActivity -d https://m.baidu.com/s?word=ip >/dev/null 2>&1
./Tcpdump -i any -p -v -s 0 -c 1 tcp port 8091 and tcp[20:4]=0x434f4e4e -w ./cache   >/dev/null 2>&1
am force-stop com.tencent.mtt
input keyevent 223;
'
fi

U=$(grep -w -aom 1 '[a-z0-9]\{32\}' ./cache)
T=$(grep -w -aom 1 '[a-z0-9]\{96\}' ./cache)
S=$(date +%Y年%m月%d日%T)
echo "❁ 当前 Q-GUID: $U"
echo "❁ 当前Q-Token: $T" 
echo ✄┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄
echo "正在生成王卡动态模式"
rn='\\r\\n'
echo "#获取时间:$S
#tiny核心
#王卡自动动态获取
     listen_port=65080;
worker_proc=0;
uid=3004;
mode=wap;
daemon=on;

http_ip=$QIP;
http_port=8090;
http_del=\"Host,X-Online-Host\";
http_first=\"[M] http://[H][U] [V]$rn Q-GUID: $U$rn Q-Token: $T$rn Host: [H]$rn Proxy-Connection: keep-alive$rn\";

https_connect=on;
https_ip=$QIP;
https_port=8091;
https_del=\"Host,X-Online-Host\";
https_first=\"[M] [H] [V]$rn Q-GUID: $U$rn Q-Token: $T$rn Host: [H]$rn Proxy-Connection: keep-alive$rn\";

dns_tcp=http;
dns_listen_port=65053;
dns_url=\"119.29.29.29\";" >./king.conf
#优化代码
echo "模式生成成功，保存为king.conf"
}

main() {
#重要，切换目录
cd "${1%/*}"
mount -o remount,rw -t auto /data >/dev/null 2>&1
mount -o remount,rw -t auto /system >/dev/null 2>&1
chmod -R 777 ../*
#读取配置文件忽略行首的\和;
eval "`grep -v '^\;' ./config.ini`"
#验证启动参数
#[ "$2" == 'stop' ] && qdgb
#[ "$2" == 'start' ] && qdml
get_token
}

main $0 $1 2>&1