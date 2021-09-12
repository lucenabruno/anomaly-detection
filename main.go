package main

import (
	"fmt"
	"time"
)

func main() {
	for {
		fmt.Println("tick")
		time.Sleep(time.Second)
	}
}
