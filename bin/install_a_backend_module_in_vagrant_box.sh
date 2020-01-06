#!/bin/bash

#CONFIG
working_dir="/vagrant"
tenant_name="diku"
logfile="/vagrant/log/current.log"
docfile="/vagrant/log/current_doc.md"


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

# default values
module_name="module_name"
module_version="module-version"
deploy="no"

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
  echo "\===> get_module"
  cd $working_dir
  git clone https://github.com/folio-org/$module_name.git 
}
function build_java_module(){
  echo "\===> build java module"
  cd $module_name
  mvn install -DskipTests
}
function build_docker_container(){
  echo "\n===> build docker container"
  docker build -t $module_name .
}
function declare_module(){
  echo "\n===> declare module"
  curl -w '\n' -X POST -D -   \
   -H "Content-type: application/json"   \
   -d @$working_dir/$module_name/target/ModuleDescriptor.json \
   http://localhost:9130/_/proxy/modules
}
function deploy_module(){
  echo "\n===> deploy module"
  sed -i "s/localhost/10\.0\.2\.15/" $working_dir/$module_name/target/DeploymentDescriptor.json 
  sed -i "s#\.\.#$working_dir#" $working_dir/$module_name/target/DeploymentDescriptor.json 
  log_run eval 'pwd'
  curl -w '\n' -D - -s \
    -X POST \
    -H "Content-type: application/json" \
    -d @$working_dir/$module_name/target/DeploymentDescriptor.json  \
    http://localhost:9130/_/discovery/modules
}
function enable_module(){
  echo "\n===> enable module"
  curl -w '\n' -X POST -D -   \
    -H "Content-type: application/json"   \
    -d "{\"id\": \"$module_name-$module_version\"}" \
    http://localhost:9130/_/proxy/tenants/$tenant_name/modules
}

function get_dependencies(){
  echo "\n===> get dependencies for: $module_name-$module_version"
  curl -w '\n' -X POST -D -   \
    -H "Content-type: application/json"   \
    -d "[ { \"id\" : \"$module_name-$module_version\" , \"action\" : \"enable\" } ]" \
    http://localhost:9130/_/proxy/tenants/$tenant_name/install?simulate=true
}
log_run(){
  echo "vagrant@$(hostname):~#${@/eval/}" >> $docfile ; "$@" >> $logfile 2>&1;
}


get_module
build_java_module
build_docker_container
declare_module
deploy_module
enable_module
get_dependencies
