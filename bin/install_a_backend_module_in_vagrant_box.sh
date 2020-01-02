#!bin/bash

module_name="module_name"
module_version="module-version"

usage() {
    cat <<EOF
    -n <value>
        Module name to install. (ex: mod-data-import)
    -v <value>
        Version of the module (ex: 1.8.0-SNAPSHOT)
    -d <yes>
        Download the module and deploy before Okapi declarations
    -h | --help
        Affichage de l'aide.
EOF
}

if [[ -z "$1" || "$1" = "-h" || "$1" = "--help" ]]
then
    usage
    exit 255
fi

while [ $1 ]; do
    case $1 in
        -d )
            shift
            module_name=$1
            ;;
        -v )
            shift
            module_version=$1
            ;;
        -d )
            shift
            deploy=$1
            ;;
       * )
            echo "Unknown arg $1"
            usage
            exit 255
    esac
    shift
done

function get_module(){
}
function build_java_module(){
}
function build_docker_container(){
}
function declare_module(){
}
function deploy_module(){
}
function enable_module(){
}
