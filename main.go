package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"math/rand"
	"net/http"
	"time"

	"github.com/gofiber/fiber"
)

func main() {
	app := fiber.New()

	go randomRequests()

	app.Get("/hello", hello)

	app.Listen(":3000")
}

func hello(c *fiber.Ctx) {
	c.Send("Hello, world 👋!")
}

func random(min, max int) int {
	rand.Seed(time.Now().UnixNano())
	v := rand.Intn(max-min+1) + min
	return v
}

// This function will sleep according to a sequence and then perform a request.
// Moreover, it will generate an outlier and sleep for a time longer than 4σ.
func randomRequests() {
	for {
		interval := []int{1, 1, 2, 3, 5, 8, 13, 21, 34, 55}
		// σ: 16.8

		for i, s := range interval {
			// pick up one interval at random
			if i+1 == random(1, 10) {
				// sleep based on the outlier
				outlier := random(70, 100) // above 4σ: 67 is an outlier
				time.Sleep(time.Duration(outlier) * time.Second)
			} else {
				time.Sleep(time.Duration(s) * time.Second)
			}
			// make a request
			fmt.Printf("request: %d\n", i)
			resp, err := http.Get("https://api.dev.mobimeo.com/echo")
			if err != nil {
				log.Fatalln(err)
			}
			//We Read the response body on the line below.
			body, err := ioutil.ReadAll(resp.Body)
			if err != nil {
				log.Fatalln(err)
			}
			sb := string(body)
			fmt.Printf("%s\n", sb)
		}
	}
}

func randomRequests2() {

}
