bin_go() {
    if ! command -v go &> /dev/null
    then
        echo "go could not be found, please install go"
        exit
    fi
    go
}

bin_docker() {

}

bin_kubectl() {

}

bin_skaffold() {
    if ! command -v skaffold &> /dev/null
    then
        echo "go could not be found, please install skaffold"
        exit
    fi
    skaffold
}

bin_telepresence() {
    if ! command -v telepresence &> /dev/null
    then
        echo "go could not be found, please install telepresence"
        exit
    fi
    telepresence
}
