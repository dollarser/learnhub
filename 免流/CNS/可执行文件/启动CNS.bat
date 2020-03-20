@echo off
echo -proxy-key                  代理头域, 默认: 'Host'
echo 手动设置  -proxy-key 'Meng'
echo -udp-flag                   udp请求标识, 默认: 'httpUDP'  
echo -listen-addr                监听地址, 默认: ':8989'  
echo -encrypt-password           加密密码, 默认不加密  
echo -tcp-timeout                tcp连接超时, 默认: 600s  
echo -udp-timeout                tcp连接超时, 默认: 30s  
echo -tcp-keepalive              tcp keepalive检测时间, 默认: 15s  
echo -pid-path                   pid文件路径, 默认不保存
echo 可选选项参数:  
echo -enable-httpDNS             httpDNS开关, 默认关闭  
echo -enable-TFO                 tcpFastOpen开关, 默认关闭  
echo -daemon                     后台运行, 默认关闭  
echo -h, --help                  显示帮助
echo Starting CNS...
CNS_win_64.exe -enable-httpDNS -encrypt-password 'huo'