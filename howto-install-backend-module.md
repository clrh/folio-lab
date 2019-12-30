# Installing a backend module

(An Okapi module which is beginning with "mod-")

```bash
# 1. get the module
git clone https://github.com/folio-org/<module_name>.git
cd <module_name>
# 2. build the module
mvn install -DskipTests # if it fails
# 3. Build the docker container with:
docker build -t <module_name> .
# 4. declare module to okapi
curl -w '\n' -X POST -D -   \
   -H "Content-type: application/json"   \
   -d @target/ModuleDescriptor.json \
   http://localhost:9130/_/proxy/modules
```

target/DeploymentDescriptor.json must be like this (had to change node name and put an absolute path:

```json
{
  "srvcId": "mod-data-import-1.9.0-SNAPSHOT",
  "nodeId": "10.0.2.15",
  "descriptor": {
    "exec": "java -Dport=%p -jar /vagrant/mod-data-import/target/mod-data-import-fat.jar -Dhttp.port=%p"
  }
}
```

```bash
# get node name
curl http://localhost:9130/_/discovery/nodes
```

```bash

# 5. deploy the module
curl -w '\n' -D - -s \
  -X POST \
  -H "Content-type: application/json" \
  -d @target/DeploymentDescriptor.json  \
  http://localhost:9130/_/discovery/modules

# 6. enable the module for tenant
curl -w '\n' -X POST -D -   \
    -H "Content-type: application/json"   \
    -d '{"id": "<module_name>-<module_version>"}' \
    http://localhost:9130/_/proxy/tenants/<tenant_name>/modules
```

Missing dependencies ? Don't panic :)

```bash
# list dependencies of a module
curl -w '\n' -X POST -D -   \
    -H "Content-type: application/json"   \
    -d '[ { "id" : "<module_name>-<module_version>" , "action" : "enable" } ]' \
    http://localhost:9130/_/proxy/<tenant_name>/diku/install?simulate=true
# now "goto 1" until all dependencies installed
```