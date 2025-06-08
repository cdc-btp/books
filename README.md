# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).

## Bind Hybrid Services 

```shell
cds bind -2 ams-books-ias
cds bind -2 books-destination
cds bind -2 books-postgres

#cds bind -2 books-auth
#cds bind -2 books-conn --kind connectivity
 
```



## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.


state="successful", action="issueJwtToken", objectType="openIdClient", objectId="ffd5ef2c-db03-43f9-b78b-9a5702df0212", category="audit.authentication", serviceProvider="books-ias-cdc",   workflow="openIdConnect", userIdentifier="b9ccd102-ffe2-420b-adf8-8101fc73c1ba", grant_type="authorization_code"

```json jwtPayload
{
    "sub":"b9ccd102-ffe2-420b-adf8-8101fc73c1ba",
    "app_tid":"1707e414-fc37-4805-82fa-7b89d51b8e6b",
    "iss":"https://cdcprovisiondemo.accounts400.ondemand.com",
    "given_name":"dina",
    "sid":"S-SP-383b7eb5-1ff4-487e-882b-de82488e29ed",
    "ias_iss":"https://cdcprovisiondemo.accounts400.ondemand.com",
    "app_att":"123",
    "aud":[
    "985cd390-2044-44cc-b297-7f91eae55aaa",
    "29dc430c-e09b-4fb0-b2a7-5b3fe85d3182",
    "ffd5ef2c-db03-43f9-b78b-9a5702df0212"
    ],
    "scim_id":"b9ccd102-ffe2-420b-adf8-8101fc73c1ba","user_uuid":"b9ccd102-ffe2-420b-adf8-8101fc73c1ba","azp":"ffd5ef2c-db03-43f9-b78b-9a5702df0212",
    "cnf":{"x5t#S256":"i9LtDigAGGcA-qSNT0rpxogl5ZHduH2JBNrvAX3Vm2I"},
    "family_name": "vinter",
     "email":  "dina.vinter@sap.com"
}
```