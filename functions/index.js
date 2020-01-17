

// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

function sendMessageToAllUsers(titleText, messageText) {
	// The topic name can be optionally prefixed with "/topics/".
var topic = 'allUsers';

	var message = {
		notification: {
			title: titleText,
			body: messageText
		},
		topic: topic
	};

	// Send a message to devices subscribed to the provided topic.
	admin.messaging().send(message)
		.then((response) => {
			// Response is a message ID string.
			console.log('Successfully sent message:', response);
			console.log('Message Body:', message.notification.body);
			return response
		})
			.catch((error) => {
			console.log('Error sending message:', error);
			return error
		});
}

// Listen for changes in all documents in the 'users/messages' collection and sends a push notification 
exports.sendNotificationOnMessageCreate = functions.firestore
	.document('persons/{personId}/messages/{messageId}')
	.onCreate((snap, context) => {
	// Get an object representing the document
	// e.g. {'name': 'Marie', 'age': 66}
	// const newValue = snap.data();

	// access a particular field as you would any JS property
	const personId = snap.get('personId');

	
	let personRef = db.collection('persons').doc(personId);
	personRef.get()
	.then(doc => {
		if (!doc.exists) {
			console.log('No such document!');
			return nil;
		} else {
			console.log('Document data:', doc.data());
			const name = doc.data().name;
			const titleText = `${name} said...`;
			const messageText = snap.get('text');

			sendMessageToAllUsers(titleText, messageText);

			return doc;
		}
	})
	.catch(err => {
		console.log('Error getting document', err);
		return err;
	});
});

	// Listen for changes in all documents in the 'users/messages' collection and sends a push notification 
exports.sendNotificationOnMessageCreate = functions.firestore
	.document('persons/{personId}/messages/{messageId}')
	.onCreate((snap, context) => {
	// Get an object representing the document
	// e.g. {'name': 'Marie', 'age': 66}
	// const newValue = snap.data();

	// access a particular field as you would any JS property
	const personId = snap.get('personId');

	
	let personRef = db.collection('persons').doc(personId);
	personRef.get()
	.then(doc => {
		if (!doc.exists) {
			console.log('No such document!');  
			return nil;
		} else {
			console.log('Document data:', doc.data());
			const name = doc.data().name;
			const titleText = `${name} said...`;
			const messageText = snap.get('text');

			sendMessageToAllUsers(titleText, messageText);

			return doc;
		}
	})
	.catch(err => {
		console.log('Error getting document', err);
		return err;
	});
});