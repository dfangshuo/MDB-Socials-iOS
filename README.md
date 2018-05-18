# MDB Socials

*by Fang Shuo*

MDB Socials is an internal social media app that allows users to create and respond to events (by indicating interest and availability).

## Features

- **Plan events:** Create events you can invite people to after picking a time and location
- **Manage events:** Easily see who's responded to your event by clicking on the number of people who have responded. See the events that others around you have created with a real-time updating newsfeed
- **Respond to events:** Indicate interest by "liking" an event
- **Weather forecasting:** Be informed of the weather conditions at your chosen place/time so you can plan accordingly.

## Implementation

- **Languages:** Swift

- **Frameworks:** Firebase, Cocoapods

MDB Socials is a Mobile App that makes database calls through a REST API[REST API](https://github.com/dfangshuo/iOSRestAPI). This keeps the business logic server-side and enables versatility for future expansion onto other platforms.

The Database used is Firebase, and significant care was taken to design the database to keep the JSON trees as flat as possible.

Authentication was handled by the Firebase Auth Console, and a variety of Cocoapods were also used, such as PromiseKit, Alamofire (to make API calls) and SwiftyBeaver.


<!-- 

Refactored MDB Socials make Firebase calls through a REST API, keeping business logic server-side*



A networking app that allows users to create & share events with their friends, view real-time updates, & express interest with RSVP functionalities -->.