#!/bin/bash

module_name="module_name"
module_version="module-version"

deploy="no"

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
        -n )
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

echo "NAME:$module_name"
echo "VERSION:$module_version"
echo "DEPLOY?$deploy"

function get_module(){
 echo "coucou"
}
function build_java_module(){
 echo "coucou"
}
function build_docker_container(){
 echo "coucou"
}
function declare_module(){
 echo "coucou"
}
function deploy_module(){
 echo "coucou"
}
function enable_module(){
 echo "coucou"
}
