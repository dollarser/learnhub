#!/system/bin/sh
main()
{
   cd "${1%/*}"
   echo "\r\n"
}
main $0 $1 2>&1