# Openapi Client Generator command
```
openapi-generator generate -i public/doc/openapi-3-v1.0.0.json -g ruby -o /tmp/test -c config.json
```
## Examples
### Run a OpenAPI catalog-api client lookup against a local running instance
API: `TenantApi`
OperationID: `list_tenants`

```
 ./test-client.rb --api-class="TenantApi" --operation="list_tenants" --host=http://localhost:3000/api/catalog/v1.0 --scheme=http
```

### Running the Rails server
The `APP_NAME` and `PATH_PREFIX`, `DEV_USERNAME`, `DEV_PASSWORD`, `RBAC_URL` 
environment variables need to be set
*If you're going to talk to sources or approval you'll need `SOURCES_URL`, `APPROVAL_URL` etc.*

```
APP_NAME=catalog PATH_PREFIX=api DEV_USERNAME=dbomhof@redhat.com DEV_PASSWORD=redhat RBAC_URL=https://ci.cloud.redhat.com/api/rbac/v1/ rails s
``` 
