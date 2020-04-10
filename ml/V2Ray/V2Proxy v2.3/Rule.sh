echo ""
echo nat表 OUTPUT链:
iptables -t nat -S OUTPUT 2>/dev/null
echo ""
echo nat表 PREROUTING链:
iptables -t nat -S PREROUTING 2>/dev/null
echo ""
echo mangle表 OUTPUT链:
iptables -t mangle -S OUTPUT 2>/dev/null
echo ""
echo mangle表 PREROUTING链:
iptables -t mangle -S PREROUTING 2>/dev/null