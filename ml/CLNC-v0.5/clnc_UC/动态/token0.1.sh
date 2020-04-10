#!/system/bin/sh
get_token(){
#启动数据
while true; do
    svc data enable
    ip addr|grep global|grep -qE '[1-9]{1,3}[0-9]{0,2}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' && break
    sleep 1
done
echo "❁ 正在获取动态验证..."

#读取配置文件接口，注释默认接口
#token_api='http://cs.xxzml.cn/k/get_tinyproxy_config.php'

#通过接口获取token
if [ "$token_api" != "" ];then
    rm -rf ./cache
    ./wget $token_api -O ./cache &>/dev/null
#注意空格if后的[]间的空格，否则失败
if [ -e ./cache ];then
    echo "获取动态验证成功"
else
    echo "动态接口失效，请更换接口"
fi
else
    echo "请配置动态接口"
fi

#优化代码
U=$(grep -w -aom 1 '[a-z0-9]\{32\}' ./cache)
T=$(grep -w -aom 1 '[a-z0-9]\{96\}' ./cache)
S=$(date +%Y年%m月%d日%T)
echo "❁ 当前 Q-GUID: $U"
echo "❁ 当前Q-Token: $T" 
echo ✄┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄ ┄
echo "正在生成王卡动态模式"
rn='\\r\\n'
if [ "$Core" != "clnc" ];then
echo "#获取时间:$S
#tiny核心
#王卡自动动态获取
listen_port=65080;
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
dns_url=\"119.29.29.29\";" >../tiny.conf
echo "王卡动态tiny模式已保存为tiny.conf"

else
echo "#获取时间:$S
#clnc核心
tcp::Global {
    tcp_listen = 0.0.0.0:6650;
}
httpMod::tunnel {
    del_line = host;
    set_first = \"[M] [H] [V]\\\r\\\nQ-GUID: $U\\\r\\\nQ-Token: $T\\\r\\\nHost: [H]\\\r\\\nProxy-Connection: keep-alive\\\r\\\n\";
}
httpMod::http {
    del_line = host;
    set_first = \"[M] http://[H][U] [V]\\\r\\\nQ-GUID: $U\\\r\\\nQ-Token: $T\\\r\\\nHost: [H]\\\r\\\n Proxy-Connection: keep-alive\\\r\\\n\";
}
tcpProxy::http_proxy {
    destAddr = 210.22.247.196:8090;
    httpMod = http;
}
tcpProxy::https_proxy {
    destAddr = 210.22.247.196:8091;
    tunnelHttpMod = tunnel;
    tunnel_proxy = on;
}
tcpAcl::firstConnect {
    tcpProxy = https_proxy;
    matchMode = firstMatch;
    reMatch = CONNECT http;
    continue: dst_port != 80;
    continue: dst_port != 8080;
    dst_port != 6650;
}
tcpAcl::CONNECT {
    tcpProxy = https_proxy;
    method = CONNECT;
}
tcpAcl::http {
    tcpProxy = http_proxy;
    reg_string != WebSocket;
    continue: method != IS_NOT_HTTP;
}
tcpAcl::http {
    tcpProxy = http_proxy;
    continue: method != IS_NOT_HTTP;
    reg_string != WebSocket;
}
dns::Global {
    dns_listen = 0.0.0.0:6653;
    cachePath = dns.cache;
    cacheLimit = 512;
}
dnsAcl {
    httpMod = http;
    destAddr = 210.22.247.196:8090;
    header_host = 119.29.29.29:80;
    query_type = A;
    query_type = AAAA;
}
dnsAcl {
    httpMod = tunnel;
    destAddr = 210.22.247.196:8091;
    header_host = 119.29.29.29:433;
    lookup_mode = tcpDNS;
}
socks5::recv_socks5 {
    socks5_listen = 0.0.0.0:1881;
    socks5_dns = 127.0.0.1:6653;
    handshake_timeout = 1;
}" >../clnc.conf
echo "王卡动态clnc模式已保存为clnc.conf"
fi
#优化代码
echo "-----------------------------------------\n"
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
#获取动态
get_token
}

main $0 $1 2>&1