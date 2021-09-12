.PHONY: help run

# vars
ECR_REG_ID = 073180495245

help: ## Help. 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## Runs service.
	@./helper.sh run

skaffold: ## Deploys on kubernetes.
	@./helper.sh skaffold dev

ecr-auth: ## Authenticates to ECR
	@./helper.sh ecr-auth ${ECR_REG_ID}
