Rails[![General Assembly Logo](https://camo.githubusercontent.com/1a91b05b8f4d44b5bbfb83abac2b0996d8e26c92/687474703a2f2f692e696d6775722e636f6d2f6b6538555354712e706e67)](https://generalassemb.ly/education/web-development-immersive)

# INTO API
https://github.com/SeanDonnellanWDI/into-client
https://seandonnellanwdi.github.io/into-client/#/

https://github.com/SeanDonnellanWDI/into-api
https://into-api.herokuapp.com/

## An explanation of the what the app does and how it works.
INTO pulls data from all your favorite media streaming services like Spotify, Netflix, Steam, and Audible and examines what you've been "into" recently. As a user of INTO, you can generate a 3x3 image of you everything you've been into over the past 7 days.

INTO is (will be*) connected to 3rd party API's in order to gather the necessary information to create a collage. Users must authenticate their accounts first via the acocunts tab, and then navigate back to the homepage to generate a collage. The collage generation engine will pull data from each of the users connected accounts and determine what the user has spent the most time doing - perhaps they've been binge watching a Netflix show, or can't get enough of Kanye's latest album, or have been playing Fortnite all night. Whatever it is that you're into, INTO will grab the album cover/tv poster/game cover of your top 9 things from the past 7 days and make a collage image to share on Instagram, Tinder, and more.

## Instructions

1. Fork and clone this repository.
1. Change into the new directory.
1. Run `bundle install` to install dependencies
1. Create and checkout a new branch, named `into-api-fork`.
1. When finishing changes, push to your fork and submit a pull request.

## List of technologies used
Git
Github
Grunt
HTML5
Bootstrap
Handlebars
CSS3
JavaScript
Ruby
Rails
Heroku
Ember.js
jQuery
AJAX
Spotify Web API

## List unsolved problems which would be fixed in future iterations.
Next Steps include:
Connecting to the Spotify API (POC)
Extrat 7 days of user history data
Filter through all history - establish the top 9 albums that user listened to that week
Order top 9 by amount of time spent listening per album (album1: 2hrs, album2: 1.5hrs, album3: 1.2hrs, etc)
Pull the album cover of these top 9 albums
Arrange the album covers in a 3x3 grid, left to right and top to bottom (most-time to least).
Convert this 3x3 grid into a jpeg or png
Provide links to share or download
Extra stretch steps:
Store the image into AWS
Display the images as a hsitory for the user
Allow user to delete individual items (maybe the user doesn't want to share the fact that they've been listening to Kidz Bop 4 for 12 hours this week - provide them a chance to remove and replace before sharing/saving/downloading)
Connect Netflix, Google Play, Amazon, Audible, Steam, PSN, Xbox, etc

## Document your planning, process and problem-solving strategy
Notes: https://imgur.com/a/ODbyiZx
ERD : https://imgur.com/a/fdh9VhW
Wireframes https://imgur.com/a/fExUV8s

Screenshot of INTO:
![screenshot of INTO app - successful update](https://i.imgur.com/kYOrGd1.png)

Process:
Create backend, CURL, test, deploy
Connect backend tables to Ember
Finish requirements for class purposes
Connect to Spotify API (in progress)
Create collage generation engine (not started)

Problem-solving strategies:
Google, check past issues, review class notes, ask a friend, then create an issue of my own. Issues included:
https://git.generalassemb.ly/ga-wdi-boston/capstone-project/issues/1223
https://git.generalassemb.ly/ga-wdi-boston/capstone-project/issues/1225
https://git.generalassemb.ly/ga-wdi-boston/capstone-project/issues/1238
https://git.generalassemb.ly/ga-wdi-boston/capstone-project/issues/1275
https://git.generalassemb.ly/ga-wdi-boston/capstone-project/issues/1279
https://git.generalassemb.ly/ga-wdi-boston/capstone-project/issues/1252

## Catalog of Routes (paths and methods) that the API expects
* ### Index
  - #### Request
    - ##### Verb
      - GET
    - ##### url
      -https://into-api.herokuapp.com/accounts
    - ##### Body
      - n/a
  - #### Response
    - ##### Status
      - 200, OK
    - ##### Body
      ```
      {accounts: [
          "account": {
            "service": "'"${SERVICE}"'",
            "username": "'"${USERNAME}"'"
          }]
      }
      ```
      - The response body will be an accounts object that contains an array of all of your accounts because this is a protected controller. There will be other attributes such as date and owner associated with each account.
* ### Create
  - #### Request
    - ##### Verb
      -POST
    - ##### url
      -https://into-api.herokuapp.com/accounts
    - ##### Body
    ```
    --request POST \
    --header "Authorization: Token token=${TOKEN}" \
    --header "Content-Type: application/json" \
    --data '{
      "account": {
        "service": "'"${SERVICE}"'",
        "username": "'"${USERNAME}"'"
      }
    }'
    ```
  - #### Response
    - ##### Status
      - 201, Created
    - ##### Body
    ```
    {accounts: [
        "account": {
          "service": "'"${SERVICE}"'",
          "username": "'"${USERNAME}"'"
        }]
    }
    ```
* ### Update
  - #### Request
    - ##### Verb
      - PATCH
    - ##### url
      -https://into-api.herokuapp.com/accounts/:id
    - ##### Body
      ```
      --request PATCH \
      --header "Content-Type: application/json" \
      --header "Authorization: Token token=${TOKEN}" \
      --data '{
        "account": {
          "service": "'"${SERVICE}"'",
          "username": "'"${USERNAME}"'"
        }
      }'
      ```
  - #### Response
    - ##### Status
      - 204, No Content
    - ##### Body
      - n/a
* ### Destroy
  - #### Request
    - ##### Verb
      - DELETE
    - ##### url
      -https://into-api.herokuapp.com/accounts/:id
    - ##### Body
      ```
      --include \
      --request DELETE \
      --header "Authorization: Bearer ${TOKEN}"
      ```
  - #### Response
    - ##### Status
      - 204, No Content
    - ##### Body
      - n/a
