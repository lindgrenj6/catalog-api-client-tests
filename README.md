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
