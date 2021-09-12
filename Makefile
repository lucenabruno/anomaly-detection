.PHONY: help build build-docker build-push run skafold ecr-auth deploy telepresence-swap terratest sniff

# vars
ECR_REG_ID = 073180495245
PORT = 3000
LABEL = anomaly-detection 
NAMESPACE = default

help: ## Help. 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Builds dummy-service-go.
	@./helper.sh build

build-docker: ## Builds docker image.
	@./helper.sh build-docker ${ECR_REG_ID}

build-push: ## Builds and pushes image to ECR
	@./helper.sh build-push ${ECR_REG_ID}

run: ## Runs service.
	@./helper.sh run

skaffold: ## Deploys on kubernetes.
	@./helper.sh skaffold dev

ecr-auth: ## Authenticates to ECR
	@./helper.sh ecr-auth ${ECR_REG_ID}

deploy: ## Builds and Deploys on Dev Cluster 
	@./helper.sh deploy

telepresence-swap: ## Swaps remote deployment bin with a local binary.
	@./helper.sh build ${ECR_REG_ID}
	@./helper.sh telepresence-swap ${PORT}

terratest: ## Runs terratest
	@echo "foo"

sniff: ## Sniffs any pod comunication
	@./helper.sh sniff ${LABEL} ${NAMESPACE}

k6: ## Runs k6
	@k6 run --vus 10 --duration 30s test/k6/test.js
