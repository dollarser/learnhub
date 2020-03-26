"${0%/*}"/Core/CuteBi start >/dev/null
#通过包名得到uid
getPackageUid() {
    packageName=${1%%_*}  #过滤包名后面的端口
    if echo $packageName | grep -q '[A-Za-z]'; then
        packageInfo=`grep -oE "^$packageName ([0-9])+" /data/system/packages.list`
        [ $? != 0 ] && return 1
        echo "$1" | grep -qE '_([0-9])+' && \
            echo "${packageInfo#* }_${1#*_}" || \
            echo "${packageInfo#* }"
    else
        echo "$1"
    fi
}
QQBrowse_uid=`getPackageUid com.tencent.mtt`
iptables -t nat -I OUTPUT -m owner --uid $QQBrowse_uid -p 6 ! --dport 8090:8091 -j ACCEPT
iptables -t nat -I OUTPUT -m owner --uid $QQBrowse_uid ! -p 6 -j ACCEPT
iptables -t mangle -I OUTPUT -m owner --uid $QQBrowse_uid -j ACCEPT
"${0%/*}"/Core/CuteBi status
