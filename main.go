package main

import "github.com/gofiber/fiber"

func main() {
	app := fiber.New()

	app.Get("/hello", hello)

	app.Listen(":3000")
}

func hello(c *fiber.Ctx) {
	c.Send("Hello, world 👋!")
}
