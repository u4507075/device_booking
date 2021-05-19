# device_booking

medical device booking system

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## phone_auth brach
Check out the phone_auth brach if you are looking for a complete step of using Firebase phone authentication (testing only on android) using flutter developed on android studio. The application starts from asking a user to enter a phone number, then requests Firebase to send a SMS code. A user enters a SMS code, then submits the data for authentication. If the authentication process successes, the application is triggered to navigate to a working page.

## cloud_firebase branch
Check out the cloud_firebase branch if you want to do Cloud firestore and Realtime database. Cloud firestore provides a non-SQL (JSON based) database where you can instantly insert, update, or delete the data to the database. The example of Cloud firestore is in the "database.dart". Cloud firestore is useful for storing typicall user data like other relational database. Realtime database is a cool feature from Google where you can have a realtime data or properties listenner. You can monitor and synchronize data across multiple devices. Realtime database is useful for app notification, broadcasting information, or system configuration synchronization. The example of Realtime database is in the "status.dart".

