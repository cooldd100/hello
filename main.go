package main

import (
	"fmt"
	"log"
	"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	// 确保只响应 GET 方法
	if r.Method != http.MethodGet {
		http.Error(w, "Method Not Allowed", http.StatusMethodNotAllowed)
		return
	}
	fmt.Fprintln(w, "Hello, world!")
}

func main() {
	// 注册处理函数
	http.HandleFunc("/hello", helloHandler)

	// 启动 HTTP 服务器监听端口 8080
	addr := ":3000"
	log.Printf("Server is running at http://localhost%s/hello\n", addr)

	if err := http.ListenAndServe(addr, nil); err != nil {
		log.Fatalf("Failed to start server: %v\n", err)
	}
}
