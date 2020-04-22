// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

//firebase cloud messaging ref
const fcm = admin.messaging();

//database ref
const db = admin.firestore();

exports.addLectureNotification = functions.firestore.document('/available_courses/{courseID}/lectures/{lectureID}').onCreate( (snapshot,context)=> {

    database.doc().

});
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
