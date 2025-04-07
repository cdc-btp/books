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
#cds bind -2 books-auth
cds bind -2 books-destination
cds bind -2 books-hana
cds bind -2 books-conn --kind connectivity
 
```



## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.
