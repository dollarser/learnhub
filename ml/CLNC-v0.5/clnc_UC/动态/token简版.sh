#!/system/bin/sh
get_token(){
echo "❁ 正在获取动态验证..."

#读取配置文件接口，注释默认接口
#token_api='http://cs.xxzml.cn/k/get_tinyproxy_config.php'

#通过接口获取token
if [ "$token_api" != "" ];then
./wget $token_api -O ./cache &>/dev/null
echo "获取成功"
#优化代码
else
echo "动态接口失效，请更换接口"
fi

U=$(grep -w -aom 1 '[a-z0-9]\{32\}' ./cache)
T=$(grep -w -aom 1 '[a-z0-9]\{96\}' ./cache)
S=$(date +%Y年%m月%d日%T)
echo "❁ 当前 Q-GUID: $U"
echo "❁ 当前Q-Token: $T" 

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