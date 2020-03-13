CuteBi Linux Network Client  
======  
Linux网络代理程序, 包括客户端跟服务端, 支持`IPV6`, `tcpFastOpen`, `UDP_Over_HttpTunnel`(需要配合CNS服务端)  
服务端CNS: https://github.com/mmmdbybyd/CNS

单独使用客户端:  
--------
    TCP:  
        1. 拥有强大的ACL，根据客户端的请求信息转发到不同的目的地址  
        2. 通过ACL限制客户端的IP数/连接数/网速/流量  
        3. 修改客户端HTTP请求头  
        4. 可使用多个代理模块，实现负载均衡  
        5. CONNECT(tunnel)代理/socks5客户端/socks5服务端  
    DNS:  
        1. 支持114DNS以及腾讯dnsPod的httpDNS协议，并且解析ipv6的时候可以让只支持解析ipv4的httpDNS映射成ipv6  
        2. 支持dnsAcl分流，支持domain分流以及queryType分流  
        3. 支持udpDNS Over tcpDNS  
        4. 支持通过http/tunnel/socks5代理  
        5. 支持dns缓存写进文件  
    更多详细功能请查看confs里的例子  
  
使用客户端+服务端:  
--------
    1. 使用自己的加密协议加密流量  
    2. 可伪装为各种HTTP流量  
    3. 使用自己的httpUDP协议，实现UDP_Over_HttpTunnel  
  
##### 启动选项:  
    必须选项参数:  
    -c                      配置文件路径  
    -p                      pid文件路径  
    -u                      有效uid(只支持tcp socket)  
    -d                      关闭daemon模式  
    -w                      运行进程数  
    无选项参数:  
    -k                      关闭核心  
    -r                      重载配置  
    -d                      前台运行  
    -v                      显示版本  
    -h                      显示帮助  
    环境变量:  
    export CLNC_INIT_CONFIG_DNS=8.8.8.8 #设置clnc读取配置文件时，获取destAddr语法的dnsIP  

##### BUG:  
　/) /)  
ฅ(• ﻌ •)ฅ  
暂无bug出现  
  
##### 下载:  
https://github.com/mmmdbybyd/CLNC/releases
