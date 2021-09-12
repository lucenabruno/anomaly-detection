#!/usr/bin/env bash
[[ "$DEBUG" ]] && set -x # Print commands and their arguments as they are executed.

set -e # Exit immediately if a command exits with a non-zero status.

# Builds App.
#
# Usage:
#  $ ./helper.sh
build() {
    # The go mod tidy command cleans up these unused dependencies
    go mod tidy
    # build
    go build -o ./bin/app
}

# Builds a development Docker image.
#
# Usage:
#  $ ./helper.sh
build_docker() {
    local ARG0="$1" # ECR
    docker build -t ${ARG0}.dkr.ecr.eu-central-1.amazonaws.com/io-team/anomaly:dev .
}

build_push() {
    local ARG0="$1" # ECR
    build_docker ${ARG0}
    docker push ${ARG0}.dkr.ecr.eu-central-1.amazonaws.com/io-team/anomaly:dev
}

run_deploy() {
    kubectl apply -k kustomize/overlays/dev
}

# Runs the main program.
#
# Usage:
#  $ ./helper.sh run
run () {
    go run main.go
}

# Runs Skaffold.
#
# Usage:
#  $ ./helper.sh skaffold
run_skaffold() {
    local ARG0="$1" # profile 
    ENV=dev skaffold dev -p ${ARG0} -f skaffold.yaml --force=false --cache-artifacts=true --port-forward=true 
}

run_ecr_auth(){
    local ARG0="$1" # ECR id
	awsudo -u mobimeo-admin aws ecr get-login-password | docker login --username AWS --password-stdin ${ARG0}.dkr.ecr.eu-central-1.amazonaws.com
}

main() {
  local ARG0="$1"
  local ARG1="$2"
  case "$ARG0" in
    build)
        build
    ;;
    build-docker)
        build_docker "$ARG1"
    ;;
    build-push)
        build_push "$ARG1"
    ;;
    deploy)
        run_deploy
    ;;
    run)
        run
    ;;
    skaffold)
        run_skaffold "$ARG1"
    ;;
    ecr-auth)
        run_ecr_auth "$ARG1"
    ;;
    telepresence-swap)
	    telepresence --swap-deployment anomaly-detection --expose "$ARG1" --run ./bin/app --port="$ARG1"

    ;;
  esac
}

main "$@"
