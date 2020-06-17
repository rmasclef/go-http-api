package main

import (
	"log"
	"net/http"
)

// Version will be overridden during 'go build'
var AppVersion = "dev"
const httpPort = "8080"

func main() {
	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		log.Printf("HTTP-API %s\n", AppVersion)
		writer.Write([]byte(AppVersion))
	})
	log.Println("listen on", httpPort)
	log.Fatal(http.ListenAndServe(":"+httpPort, nil))
}
