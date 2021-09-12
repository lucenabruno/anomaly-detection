# Description

This service will sleep according to a sequence(e.g. Fibonacci) and then will performa request. It will also generate an random outlier above 4σ and sleep for this interval before making a request.


# Steps

1) go run main
2) go mod init github.com/mobimeo/anomaly-detection-example
3) go get -u github.com/gofiber/fiber/v2

# Fiber

Test Features:

- [] Robust routing
- [] Serve static files
- [] Low memory footprint
- [] API endpoints
- [] Middlewares
- [] Template engines
- [] WebSocket support

# TODO

- [] bin.sh: docker, go, kubectl, skaffold, telepresence
- [] refactor ecr-auth
- [] refactor image generated
- [] refactor swap name
