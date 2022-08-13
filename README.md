# Office365 Dataverse Project in Flutter

This project enables the user search and filter data from Office365 dataverse. This project can be publish and run for windows desktop, macOs desktop, web  and mobile (both ios & android)

## Source Code Files & Folders

* Main : ~/lib/main.dart
* Data Layer : ~/lib/data/dataverse.dart
* UI Screens : ~/lib/widget/ui/searchscreen.dart
* Widgets : ~/lib/ui/widgets.dart
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
 



... to be continued...
