@echo off
echo -proxy-key                  ����ͷ��, Ĭ��: 'Host'
echo �ֶ�����  -proxy-key 'Meng'
echo -udp-flag                   udp�����ʶ, Ĭ��: 'httpUDP'  
echo -listen-addr                ������ַ, Ĭ��: ':8989'  
echo -encrypt-password           ��������, Ĭ�ϲ�����  
echo -tcp-timeout                tcp���ӳ�ʱ, Ĭ��: 600s  
echo -udp-timeout                tcp���ӳ�ʱ, Ĭ��: 30s  
echo -tcp-keepalive              tcp keepalive���ʱ��, Ĭ��: 15s  
echo -pid-path                   pid�ļ�·��, Ĭ�ϲ�����
echo ��ѡѡ�����:  
echo -enable-httpDNS             httpDNS����, Ĭ�Ϲر�  
echo -enable-TFO                 tcpFastOpen����, Ĭ�Ϲر�  
echo -daemon                     ��̨����, Ĭ�Ϲر�  
echo -h, --help                  ��ʾ����
echo Starting CNS...
CNS_win_64.exe -enable-httpDNS -encrypt-password 'huo'