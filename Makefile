.PHONY: help run

# vars
ECR_REG_ID = 073180495245

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
