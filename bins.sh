bin_go() {
    if ! command -v go &> /dev/null
    then
        echo "go could not be found, please install from here https://github.com/go"
        exit
    fi
}

bin_docker() {

}

bin_kubectl() {

}

bin_skaffold() {


}

bin_telepresence() {

}
