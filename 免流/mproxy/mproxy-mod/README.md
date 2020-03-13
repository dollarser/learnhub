# mproxy-mod
同时支持http和https自定义头域代理的mproxy实现。

## 更新
重新修改了源码，在保证其原有功能的基础上，新加了两个参数"-r" 和"-m"。

### "-r <server and port>":将流量无条件转发至指定的[服务器:端口]
    ./mproxy -l 8080 -r 127.0.0.1:443
"-r"参数转发流量时，与"-h"参数的区别在于，其不转发CONNECT(http_tunnel)连接的header信息，而"-h"参数是不处理数据，全部转发(header+data)。

### -m <ml key string>:指定头域关键字以替换并行使原"Host:"的功能
	./mproxy -l 8080 -m Lbxx:
"-m"参数指定的字符串将被用来确定真实的remote host和port，使用时将忽略原"Host:"头域的内容。
#### 注意：-h -r -m三个参数尽量不要一起用，优先级-h > -m > -r 。
	./mproxy -l 8080 -h xxxx -m xxxx -r xxxx
如上的命令只有-h起作用，-m和-r将失效。

	./mproxy -l 8080 -m Lbxx: -r 127.0.0.1:443
上面的命令，只有当连接header中不包含"Lbxx:"时，才会转发至127.0.0.1:443；如果包含，则仍将转发至"Lbxx:"所确定的地址。

原使用参数-h等可参照原项目地址。

## 使用
- 上传源码，秒编译一下：gcc -o mproxy mproxy.c 
- 启动mproxy：./mproxy -l 8080 -m Lbxx: -d 
- 关闭mproxy： ps -ef | grep mproxy | grep -v grep | cut -c 9-15 | xargs kill -s 9 
- 查看端口：netstat -tupnl 看到8080端口有了，就成功了，此端口支持同时代理包含自定义头域"Lbxx:"的HTTP和CONNECT流量。

## 对于云免应用  
- 本代理适用于搭配tiny、http注射器、openvpn等使用，模式可自行指定
- 对于tiny  

    ./mproxy -l 8080 -m Lbxx: -r 127.0.0.1:443

 接入点APN可以设置cmnet加上127.0.0.1:65080的代理。  
 文件中包含一个已失效的tiny模式示例。  
 参考[云代理搭建](http://bybbs.org/read-65245-1.html)提到的教程  
- 对于http注射器  

    ./mproxy -l 8080 -m Lbxx: -r 127.0.0.1:22(22 is your ssh port)

 参考:
> 1.远程代理[your VPS ip]:8080  
> 2.有效载荷(参考)：CONNECT migumovie.lovev.com:443 [protocol][crlf][delay_split]GET http://miguvod.lovev.com:8080/ [protocol][crlf]User-Agent:  MGPlayer4Android/v6.6.3[crlf]Accept:  */*[crlf]Range:  bytes=0-[crlf]Connection: Keep-Alive[crlf]Host: miguvod.lovev.com:8080[crlf]Icy-MetaData:  1[crlf][crlf]  
> 3.启动ssh  

- 对于OPENVPN  

    ./mproxy -l 8080 -m Lbxx: -r 127.0.0.1:443

 参考:  
> http-proxy-option EXT1 "GET http://miguvod.lovev.com:8080/?"   
> http-proxy-option EXT1 "Accept:  */*"   
> http-proxy-option EXT1 "Host: miguvod.lovev.com:8080"   
> http-proxy-option EXT1 "User-Agent:  MGPlayer4Android/v6.6.3"  
> http-proxy-option EXT1 "Icy-MetaData:  1"  
> http-proxy [your VPS ip] 8080  
> 
> remote miguvod.lovev.com 443 tcp-client  

## 注意
- 示例中代理支持的自定义头域为'Lbxx:'，可以自行指定为其他任意适当长度的字符串，达到防盗用的目的。
- 模式中要求http部分Lbxx: [H]要紧跟Host:头域之后，https无要求
- 云免知识从八云论坛的蜡笔小新。同学处学得很多，谢谢！
- 源码修改自[examplecode/mproxy](https://github.com/examplecode/mproxy)，感谢！

