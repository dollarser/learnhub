package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"net"
	"regexp"
	"strconv"
	"strings"
	"time"
)
var Regexp = regexp.MustCompile("VPN ([\\s\\S]*?)\r\n")
var rate int64
func main() {
	var port int
	flag.IntVar(&port, "port", 18888, "本地代理端口")
	flag.Int64Var(&rate, "rate", 500, "限制速度")
	flag.Parse()
	fmt.Printf("服务器监听端口：%s\r\n服务器限速：%skbs\r\n",  strconv.Itoa(port),strconv.FormatInt(rate,10))
	log.SetFlags(log.LstdFlags|log.Lshortfile)
	l, err := net.Listen("tcp", ":"+strconv.Itoa(port))
	if err != nil {
		log.Panic(err)
	}

	for {
		client, err := l.Accept()
		if err != nil {
			log.Panic(err)
		}
		go handleClientRequest(client)
	}
}
//取文本中间
func GetBetweenStr(str, start, end string) string {
	n := strings.Index(str, start)
	if n == -1 {
		n = 0
	} else {
		n = n + len(start)  // 增加了else，不加的会把start带上
	}
	str = string([]byte(str)[n:])
	m := strings.Index(str, end)
	if m == -1 {
		m = len(str)
	}
	str = string([]byte(str)[:m])
	return str
}

func handleClientRequest(client net.Conn) {
	if client == nil {
		return
	}
	defer client.Close()

	var b [1024]byte
	_, err := client.Read(b[:])
	if err != nil {
		log.Println(err)
		return
	}
	var address string
	address = GetBetweenStr(string(b[:]),"VPN ","\r\n")
	if address == ""{
		address ="127.0.0.1:443"
	}
	//address = Regexp.FindStringSubmatch(string(b[:]))[1]
	//获得了请求的host和port，就开始拨号吧
	server, err := net.Dial("tcp", address)
	if err != nil {
		log.Println(err)
		return
	}
	fmt.Fprint(client, "HTTP/1.1 200 Connection established\r\n\r\n")
	fmt.Printf("客户端IP: %s 转接到服务器IP：%s\r\n",  client.RemoteAddr().String(),address)
	//进行转发
	//go io.Copy(server, client)
	//上行 限速500kb
	go CopyRate(server, client,1024*rate/5)
	//io.Copy(client, server)
	//下行 限速500kb
	CopyRate(client, server,1024*rate/5)
}
//限速模块
func CopyRate(dst io.Writer, src io.Reader, bps int64) (written int64, err error) {
	throttle := time.NewTicker(time.Second)
	defer throttle.Stop()

	var n int64
	for {
		n, err = io.CopyN(dst, src, bps)
		if n > 0 {
			written += n
		}
		if err != nil {
			if err == io.EOF {
				err = nil
			}
			break
		}
		<-throttle.C // rate limit our flows
	}
	return written, err
}
