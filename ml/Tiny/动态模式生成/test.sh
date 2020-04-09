#!/system/bin/sh
main()
{
	cd "${1%/*}"
	echo "不要用qq传文字, 会把换行换成回; 需要传，就直接传文件"
	echo "\r\n"
}
main $0 $1 2>&1