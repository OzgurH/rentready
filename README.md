# Office365 Dataverse Project in Flutter

This project enables the user search and filter data from Office365 dataverse. This project can be publish and run for windows desktop, macOs desktop, web  and mobile (both ios & android)

## Source Code Files & Folders

* Data Layer : ~/lib/data/dataverse.dart
* API getter : ~/lib/data/service.dart
* UI Screens : ~/lib/main.dart
* Unit Tests : ~/tests/unit_test.dart
* Widget tests : ~/tests/widget_test.dart

## Data Layer

App requests dataverse 'Accounts' table with the following columns only 'accountid,name,accountnumber,statecode,address1_stateorprovince,entityimage'.

## Search and Filtering
Dataverse APIs provides easy to use url parameters for search and filter purposes. Search and filtering parameters are created at runtime according to user selections. Endpoint url string is dynamically changes with filter values.


## Limitations & Risks

This assignment has some limitations and risks that need to be taken care of in the real world, as it can be accomplished quickly and the different features of the developer are tested.

* The account holds the dataverse table is a trial and valid for 1 month until September 11th, 2022. 
* Internet connection status is not checking before api calls.
* Data paging structure isnt implemented. App gets all the data. 
 
## Authentication

Dataverse API token is desgined as providing from backend, because of Microsoft Authentication Library (MSAL) support in flutter only possible with 3rd party components which isnt stable and it requires extra effort. Using client certificate is conceivable for authentication but it requires updating app regularly in the app market places when certificate is expired. I primarily focused the requirements on the assignment.

## Tests

Unit & Widget tests can be found at ~/tests/.
Run test with this terminal command : 
```
flutter test
```

## Debug

If you are on standart nvoirment (non-docker) Run project with this terminal command : 
```
flutter run
```
In dockerized envoirment :
```
flutter run -d web-server
```
 



## Docker Container

Microsoft's Dart container is used for starting point:
```
https://github.com/Microsoft/vscode-dev-containers
```

* Github extension used for enabling transfers of large files
* Only web build can run in Debian 
* Installed Linux releases of Flutter , chromium and anroid SDK for arm64 (Mac M1 processor)
* Install scripts and env variables set on dockerfile but not tested.


