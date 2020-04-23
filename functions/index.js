// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

//firebase cloud messaging ref
const fcm = admin.messaging();

//database ref
const Firestore = admin.firestore();

//users ref
const usersRef = Firestore.collection('users');


exports.addLectureNotification = functions.firestore.document('/available_courses/{courseID}/lectures/{lectureID}').onCreate(async (snapshot,context)=> {

    const courseID = context.params.courseID;
    const lectureID = context.params.lectureID;

    const courseRef = Firestore.collection('available_courses');

    const courseStudentsRef = Firestore.collection('available_courses').doc(courseID).collection('students');

    const courseStudentsSnapshot = await courseStudentsRef.get();

    const timestamp = admin.firestore.FieldValue.serverTimestamp();

    courseStudentsSnapshot.forEach(async (doc )=>{
        if(doc.exists){
            const userID = doc.id;
            usersRef.doc(userID).collection('notifications').doc().set({date: timestamp,lectureID: lectureID,imageUrl: snapshot.data().image,isSeen:false , title: snapshot.data().title });

            const courseInfo = await courseRef.doc(courseID).get();

            usersRef.doc(userID).collection('newLectures').doc(lectureID).set({date:timestamp ,courseName : courseInfo.data().courseName,isCompleted: false,title:snapshot.data().title });
        }
    });

});


exports.addCourseNotification = functions.firestore.document('/available_courses/{courseID}/notifications/{notificationID}').onCreate(async (snapshot,context)=> {

    const courseID = context.params.courseID;

    const courseRef = Firestore.collection('available_courses');

    const courseStudentsRef = Firestore.collection('available_courses').doc(courseID).collection('students');

    const courseStudentsSnapshot = await courseStudentsRef.get();

    const timestamp = admin.firestore.FieldValue.serverTimestamp();

    courseStudentsSnapshot.forEach(async (doc )=>{
        if(doc.exists){
            const userID = doc.id;
            usersRef.doc(userID).collection('notifications').doc().set({date: timestamp,imageUrl: snapshot.data().image,isSeen:false , title: snapshot.data().title });
        }
    });

});


exports.addGlobalNotification = functions.firestore.document('/global_notifications/{notificationID}').onCreate(async (snapshot,context)=> {

    const usersRef = Firestore.collection('users');

    const usersSnapshot = await usersRef.get();

    const timestamp = admin.firestore.FieldValue.serverTimestamp();

    usersSnapshot.forEach(async (doc )=>{
        if(doc.exists){
            const userID = doc.id;
            usersRef.doc(userID).collection('notifications').doc().set({date: timestamp,imageUrl: snapshot.data().image,isSeen:false , title: snapshot.data().title });
        }
    });

});


exports.sendNotification = functions.firestore.document('/users/{userID}/notifications/{notificationID}').onCreate(async(snapshot,context) => {

    const userID = context.params.userID;

    const payload = {notification: {
        title: 'New Notification',
        body: snapshot.data().title,
        icon:snapshot.data().imageUrl}};

    const userRef = Firestore.collection('users').doc(userID);

    const userTokens = await userRef.collection('tokens').get();

    userTokens.forEach((token)=>{
            if(token.exists){
                const userToken = token.id;
                return fcm.sendToDevice(userToken,payload);
            }
        });
});