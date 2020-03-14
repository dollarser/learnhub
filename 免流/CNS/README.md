# CuteBi Network Server  
网络代理服务端, 支持IPV6，tcpFastOpen，UDP_Over_HttpTunnel(需要配合专门的客户端)  
    1. 普通的CONNECT代理服务器(暂时不考虑添加普通http支持)  
    2. 实现与114DNS以及腾讯的dnsPod一样的httpDNS服务端  
    3. 配合专门的客户端可以实现TCP/UDP全局代理, 目前只有: https://github.com/mmmdbybyd/CLNC
  
单独服务端:  
--------
    1. 普通的CONNECT代理服务器(暂时不考虑添加普通http支持)  
    2. 实现与114DNS以及腾讯的dnsPod一样的httpDNS服务端  

服务端+客户端:
--------
    1. 使用自己的加密协议加密流量   
    2. 可伪装为各种HTTP流量  
    3. 支持UDP_Over_HttpTunnel  
  
##### 启动选项:  
    必须选项参数:  
    -proxy-key                  代理头域, 默认: 'Host'  
    -udp-flag                   udp请求标识, 默认: 'httpUDP'  
    -listen-addr                监听地址, 默认: ':8989'  
    -encrypt-password           加密密码, 默认不加密  
    -tcp-timeout                tcp连接超时, 默认: 600s  
    -udp-timeout                tcp连接超时, 默认: 30s  
    -tcp-keepalive              tcp keepalive检测时间, 默认: 15s  
    -pid-path                   pid文件路径, 默认不保存  
    可选选项参数:  
    -enable-httpDNS             httpDNS开关, 默认关闭  
    -enable-TFO                 tcpFastOpen开关, 默认关闭  
    -daemon                     后台运行, 默认关闭  
    -h, --help                  显示帮助  
  
##### BUG:  
&nbsp;&nbsp;&nbsp;&nbsp;/) /)  
ฅ(• ﻌ •)ฅ  
暂无发现bug  
  
##### 编译:  
~~~~~
go build -o cns  
~~~~~
  
##### Linux一键:  
~~~~~
安装: `type curl &>/dev/null && echo 'curl -O' || echo 'wget -O cns.sh'` http://pros.cutebi.xyz:666/cns/cns.sh && sh cns.sh
卸载: `type curl &>/dev/null && echo 'curl -O' || echo 'wget -O cns.sh'` http://pros.cutebi.xyz:666/cns/cns.sh && sh cns.sh uninstall

