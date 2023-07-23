@echo off

@echo Starting the data Import Process
@pause

@echo Authorizing the QA Org to import the data
@rem sfdx force:auth:web:login -a QA -r https://login.salesforce.com -s

@echo Beginning Data Export of Account object
call sf data export tree --query "SELECT Id,Name FROM Account limit 2" -o QA -d JSON > Account.json
@pause

@echo Authorizing the Dev Org to import the data
@rem sfdx force:auth:web:login -a dev -r https://login.salesforce.com -s

@echo Importing data to Dev Org
call sf data import tree --files JSON/Account.json --target-org dev

@echo Data Import Process Complete