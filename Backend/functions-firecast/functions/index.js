var functions = require('firebase-functions');

// Import and initialize the Firebase Admin SDK.
const admin = require('firebase-admin');

var serviceAccount = require("./trainingplanner-691cc-firebase-adminsdk-lrnln-a11d5d2a6d.json")
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://trainingplanner-691cc.firebaseio.com"
});

var firebase = require("firebase");
var config = {
  apiKey: "AIzaSyAxT4g5AgSx3HA8i82mA-xiSMypggqDxCI",
  // authDomain: "trainingplanner-691cc.firebaseapp.com",
  databaseURL: "https://trainingplanner-691cc.firebaseio.com/",
  serviceAccount: 'trainingplanner-691cc-firebase-adminsdk-lrnln-a11d5d2a6d.json'
};

firebase.initializeApp(config);

exports.signIn = functions.https.onRequest((request, response) => {

  var email = request.body.email
  var password = request.body.password

  console.log("Printing username recieved " + request.body.email);
  console.log("Printing password recieved " + request.body.password);

  firebase.auth().signInWithEmailAndPassword(email, password).then(function (firebaseUser) {
    // Success 
    console.log("user signed in successfully " + firebaseUser);
    response.status(200).send(firebaseUser);
  }).catch(function (error) {
    // Handle Errors here.
    var errorCode = error.code;
    var errorMessage = error.message;
    // ...
    console.log("Error recieved " + errorMessage);
    response.status(errorCode).send("Error occurred");
  });
});

const isLoggedIn = (token, callback) => {
  console.log("Method called with token " + token)
  const tokenVerificationFlag = admin.auth().verifyIdToken(token)

  const isLoggedInFlag = tokenVerificationFlag.then(function (decodedToken) {
    console.log("Inside success")
    // var uid = decodedToken.uid;
    // ...
    console.log(token)
    console.log(decodedToken)
    callback(true)
    // return true
  }).catch(function (error) {
    // Handle error
    console.log("Inside error")
    callback(false)
    // return false
  })
  return isLoggedInFlag
}

// const validateFirebaseIdToken = (req, res, next) => {
//   console.log('Check if request is authorized with Firebase ID token');

//   if ((!req.headers.authorization || !req.headers.authorization.startsWith('Bearer ')) &&
//       !req.cookies.__session) {
//     console.error('No Firebase ID token was passed as a Bearer token in the Authorization header.',
//         'Make sure you authorize your request by providing the following HTTP header:',
//         'Authorization: Bearer <Firebase ID Token>',
//         'or by passing a "__session" cookie.');
//     res.status(403).send('Unauthorized');
//     return;
//   }

//   let idToken;
//   if (req.headers.authorization && req.headers.authorization.startsWith('Bearer ')) {
//     console.log('Found "Authorization" header');
//     // Read the ID Token from the Authorization header.
//     idToken = req.headers.authorization.split('Bearer ')[1];
//   } else {
//     console.log('Found "__session" cookie');
//     // Read the ID Token from cookie.
//     idToken = req.cookies.__session;
//   }
//   admin.auth().verifyIdToken(idToken).then(decodedIdToken => {
//     console.log('ID Token correctly decoded', decodedIdToken);
//     req.user = decodedIdToken;
//     next();
//   }).catch(error => {
//     console.error('Error while verifying Firebase ID token:', error);
//     res.status(403).send('Unauthorized');
//   });
// };


exports.getTrainings = functions.https.onRequest((request, response) => {
  console.log("Printing the token " + request.headers.authorization)
  console.log("After splitting the Bearer " + request.headers.authorization.split('Bearer ')[1])

  isLoggedIn(request.headers.authorization.split('Bearer ')[1], function (returnValue) {
    console.log("Executing with value " + returnValue)
    if (returnValue == true) {
      var rootRef = admin.database().ref("/trainings");
      // return event.data.val();
      // rootRef.once("value", function(data) {
      //   // do some stuff once
      //   request.send(data)
      // });

      // rootRef.once('value').then(function(snapshot) {
      //   var username = snapshot.val();
      //   // ...
      //   request.send(username)
      // });

      rootRef.on("value", function (snapshot) {
        console.log(snapshot.val());
        response.status(200).send(snapshot.val())
      }, function (error) {
        console.log("Error: " + error.code);
      });
    }
    else {
      response.status(401).send("Permission Denied. unauthorised access")
    }
  });


});

