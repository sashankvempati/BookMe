Group Project - README Template
===

# BookMe

## User Stories

The following **required** functionality is completed:

- [x] User can see three different tabs
- [x] User can click on available room and see a detailed view

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/VH8DtXje1M.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## User Stories

The following **required** functionality is completed:

- [x] User can log in 
- [x] User can sign up
- [x] User stays logged in
- [x] User can log out

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/b32Sm2OX7A.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Allows users to rent a room at someones house and use it as a study space.

### App Evaluation

- **Category:** Marketplace/ Hospitality
- **Mobile:** This app is primarily developed for a mobile device but has the potential to be used on a computer similar to Airbnb.
- **Story:** Allows users to rent out study rooms that are within their neighborhood.
- **Market:** Anyone is able to post their homes as a study space. In order to rent out a study room, the user must have a .edu email address to verify that they are a student. 
- **Habit:** This app would be used as often as the user requires. Finals/midterm weeks would have more activity as user would most likely need more time to study.
- **Scope:** This app would initially allow user to study, but eventually could be used as a space to hold study sessions, review sessions, or meeting spaces.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can login/sign up
* User can add/edit their payment option
* User can update their location
* Profile pages for users
* Settings (payment options add/delete)
* User can post their home as an avaiable study space
* User can view and select from availble study 

**Optional Nice-to-have Stories**

* A rating for the owner of the house and the person renting the house
* A map view of the available houses within your area


### 2. Screen Archetypes

* Login/Sign up - user logs in or signs up 
    * Upon first download of the app, the user is asked to create an account if they do not have one, or sign into their existing account 
* Room Selection Screen
    * User is able to look at all the rooms that are availbe to reserve for studying 
* Room Details Screen
    * User can see more details about the room that they are trying to reserve such as pictures and amenities
* Payment Screen
    * Allows user to pay for the room that they are trying to reserve
* Profile Screen
    * User can look at their own profile with a history of rooms they've booked 
* Settings Screen
    * Lets people update their payment methods

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Room Selection
* Profile
* Settings

**Flow Navigation** (Screen to Screen)

* Login -> account creation if no account exists
* Room Selection-> Room Details
* Room Selection-> Payment Screen
* Profile
* Settings

## Wireframes
<img src="https://i.imgur.com/ELS8M5G.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/8dQW64u.png" width=800>

### [BONUS] Interactive Prototype

## Schema 
### Models
Room Listings Screen

| Property     | Type     | Description |
| --------     | -------- | -------- |
| Image        | File     | Image that user posts    |
| Rate         | String   | Price of room per hour
| Distance     | String   | Distance away from your current location
| Availability | String   | Available times for the current day


Room Details Screen

| Property | Type | Description |
| -------- | -------- | -------- |
| Image    | File     | Image that user posts     |
| Rate     | String   | Price of room per hour|
| Profile Picture| File | Image of the host|
| Host Bio | String | Brief description about host|
| Amenities | String | List of resources/tools that come with the room |
| Timings | String | List of all the available timings that the host lends out the room |


Booking Confirmation Screen

|  Property | Type | Description |
| -------- | -------- | -------- |
| Booking Confirmation     | String     | Confirms your booking     |
| Study Room Description | String | Shows location of study rooom |
| Address | String | Address of the study room |
| Time | String | The times that the room is reserved for| 
| Image | File | Image of the user |
| Name | String | Description of the user such as name and bio |
| Total Amount | String | Shows the total amount due along with a breakup of the charges |



### Networking
#### List of network requests by screen
   - Login/SignUp Screen
      - (ReadU/GET) Query logged in user object
      - (CreateU/POST) Create a new user object
   - Profile Screen
      - (ReadU/GET) Query logged in user object
      - (UpdateU/PUT) Update user password
   - Room Listings Screen
      - (ReadR/GET) Query all availiable study rooms with matching time, date and location based on user input
   - Room Details Screen
      - (ReadR/GET) Query for all details of a single selected study room 
   - Booking Confirmed Screen
      - (UpdateR/PUT) Update avaliability of the room
   - Payments Screen
      - (ReadP/GET) Query all Payment objects with user as main
      - (CreateP/POST) Create a new Payment object
      - (UpdateP/PUT) Update Payment information for a particular payment
      - (DeleteP/DELETE) Delete a Payment object

| CRUD | HTTP Verb | Example |
| -------- | -------- | -------- |
| ReadU     | GET     | Get user data, login status, bookings, etc     |
| CreateU | POST | Create a new User |
| UpdateU | PUT | Update the users info(like password) |
| ReadR     | GET     | Fetching available study rooms for the user to view     |
| ReadR1     | GET     | Fetching all details of a single study room for the user to view     |
| UpdateR | PUT | Update the room's availiability |
| ReadP     | GET     | Fetching all current payment info for a specific user     |
| CreateP | POST | Create a new payment method(example: a credit card) |
| UpdateP | PUT | Update the users credit card information |
| DeleteP | DELETE | Delete the users credit card information |
