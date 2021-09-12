#!/usr/bin/env bash
[[ "$DEBUG" ]] && set -x # Print commands and their arguments as they are executed.

set -e # Exit immediately if a command exits with a non-zero status.

run () {
    go run main.go
}

main() {
  local ARG0="$1"
  case "$ARG0" in
    run)
        run
    ;;
  esac
}

main "$@"
