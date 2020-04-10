+ 自动在脚本所在目录外生成tiny或clnc脚本
其中token_latest.sh为模式生成脚本
token_min.sh只是单纯获取token, 不生成脚本

+  配合CRON定时任务，让模式自动更新

解压文件SP8-CRON_v2.tar.gz

执行其中的安装脚本Install.sh安装crontab

添加定时任务

打开文件夹: /system/etc/cron.d/root。
添加如下内容, 让token.sh脚本没30分钟执行一次, 注意以下内容的路径，设置成自己token.sh所放的路径:
```*/30 * * * * /system/xbin/clnc_UC/动态/token_latest.sh```
或直接将此文件夹下的root移动到/system/etc/cron.d/root

语法说明：
+ crontab的格式为: `* * * * * Command`
+ 其中前5个`*` 分别代表分钟0\~59、小时0\~23、日期1\~31、月份1\~12、星期0\~7;
+ 每个`*`有以下操作符
  + `*` 取所有值，例如 `*`
  + `/` 每过多久执行一次，例如 `*/5`, 每5执行一次
  + `-` 从a到b之间执行，例如 `1-4`, `1-4/2`; 分别代表1-4均执行，1-4每2执行一次
 * `,` 散列的值，例如 `1,3`, `2,15,23`

+ 杀掉进程

    \# 查看进程pid

    pgrep crond

    \# 根据进程pid杀掉进程

    kill -9 pid

+ 启动任务
```sh /system/etc/init.d/S99CRON-SP8```
    