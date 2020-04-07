// tcp.go
package main

import (
	"bytes"
	//"fmt"
	"log"
	"net"
	"strings"
	"time"
)

/* 把fromConn的数据转发到toConn */
func tcpForward(fromConn, toConn *net.TCPConn, payload []byte) {
	defer fromConn.Close()
	defer toConn.Close()

	var RLen, CuteBi_XorCrypt_passwordSub int
	var err error
	for {
		fromConn.SetReadDeadline(time.Now().Add(tcp_timeout))
		toConn.SetReadDeadline(time.Now().Add(tcp_timeout))
		if RLen, err = fromConn.Read(payload); err != nil {
			return
		}
		if len(CuteBi_XorCrypt_password) != 0 {
			CuteBi_XorCrypt_passwordSub = CuteBi_XorCrypt(payload[:RLen], CuteBi_XorCrypt_passwordSub)
		}
		toConn.SetWriteDeadline(time.Now().Add(tcp_timeout))
		if _, err = toConn.Write(payload[:RLen]); err != nil {
			return
		}
	}
}

/* 从header中获取host */
func getProxyHost(header []byte) string {
	hostSub := bytes.Index(header, proxyKey)
	if hostSub < 0 {
		return ""
	}
	hostSub += len(proxyKey)
	hostEndSub := bytes.IndexByte(header[hostSub:], '\r')
	if hostEndSub < 0 {
		return ""
	}
	hostEndSub += hostSub
	if len(CuteBi_XorCrypt_password) != 0 {
		host, err := CuteBi_decrypt_host(header[hostSub:hostEndSub])
		if err != nil {
			log.Println(err)
			return ""
		}
		return string(host)
	} else {
		return string(header[hostSub:hostEndSub])
	}
}

/* 处理tcp会话 */
func handleTcpSession(cConn *net.TCPConn, header []byte) {
	defer log.Println("A tcp client close")

	/* 获取请求头中的host */
	host := getProxyHost(header)
	if host == "" {
		log.Println("No proxy host: {" + string(header) + "}")
		cConn.Write([]byte("No proxy host"))
		cConn.Close()
		return
	}
	log.Println("proxyHost: " + host)
	//tcpDNS over udpDNS
	if enable_dns_tcpOverUdp && strings.HasSuffix(host, ":53") == true {
		dns_tcpOverUdp(cConn, host, header)
		return
	}
	/* 连接目标地址 */
	if strings.Contains(host, ":") == false {
		host += ":80"
	}
	sAddr, resErr := net.ResolveTCPAddr("tcp", host)
	if resErr != nil {
		log.Println(resErr)
		cConn.Write([]byte("Proxy address [" + host + "] ResolveTCP() error"))
		cConn.Close()
		return
	}
	sConn, dialErr := net.DialTCP("tcp", nil, sAddr)
	if dialErr != nil {
		log.Println(dialErr)
		cConn.Write([]byte("Proxy address [" + host + "] DialTCP() error"))
		cConn.Close()
		return
	}
	sConn.SetKeepAlive(true)
	sConn.SetKeepAlivePeriod(tcp_keepAlive)
	/* 开始转发 */
	log.Println("Start tcpForward")
	go tcpForward(cConn, sConn, make([]byte, 8192))
	tcpForward(sConn, cConn, header)
}
