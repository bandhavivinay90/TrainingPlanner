

var functions = require('firebase-functions');
var TrainingModule = require('./Training/TrainingModule');

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

exports.createNewUser = functions.https.onRequest((request, response) => {

  var emailID = request.body.email
  var password = request.body.password
  var name = request.body.name
  var shortDescription = request.body.shortDescription

  console.log(emailID)
  console.log(password)

  console.log("Printing username recieved " + request.body.email);
  console.log("Printing password recieved " + request.body.password);

  const userCreation = firebase.auth().createUserWithEmailAndPassword(emailID, password)
  userCreation.then(function (user) {

    var currentUser = firebase.auth().currentUser

    currentUser.sendEmailVerification()

    //Send a verification email to the user ...

    //Add the user in the json tree ...

    admin.database().ref('users/' + currentUser.uid).set({
      name: name,
      email: emailID,
      description: shortDescription
    }).then(function (abcd) {
      console.log("Inside success" + abcd)
      response.status(200).send(currentUser.uid)
    }).catch(function (error) {
      console.log("Failed to create new entry in database" + error)
      response.status(401).send(error)
    })

    // const changeRequest = currentUser.updateProfile({displayName:name})
    // changeRequest.then(function () {

    // }).catch(function (error) {

    // })

  }).catch(function (error) {
    response.status(401).send(error)
  })
});


exports.signIn = functions.https.onRequest((request, response) => {

  var email = request.body.email
  var password = request.body.password

  console.log("Printing username recieved " + request.body.email);
  console.log("Printing password recieved " + request.body.password);

  firebase.auth().signInWithEmailAndPassword(email, password).then(function (firebaseUser) {
    // Success 
    console.log("user signed in successfully " + firebaseUser);

    firebaseUser.getIdToken().then(function (token) {
      console.log("Token check " + token);
      // if(firebaseUser.isEmailVerified){
      console.log("Email is verified " + firebaseUser.isEmailVerified)

      //Collect more information about the user from the database ...
      admin.database().ref('users/' + firebaseUser.uid).once('value').then(function (snapshot) {

        console.log("Entered inside database access then" + firebaseUser.stsTokenManager)
        console.log("Entered inside database access then" + firebaseUser)
        var userSnapshot = snapshot.val()
        console.log(snapshot)

        var userDictionary = {
          user: {
            "uid": firebaseUser.uid,
            "fullName": userSnapshot.name,
            "description": userSnapshot.description,
            "emailID": firebaseUser.email,
            "imageURL": null
          },
          "accessToken": token,
          "refreshToken": firebaseUser.refreshToken
        }
        response.status(200).send(userDictionary)
      })
    }).catch(function (error) {
      console.log("Entered inside error")
      var errorCode = error.code;
      var errorMessage = error.message;
      console.log("Error recieved " + errorMessage)
      response.status(errorCode).send(errorMessage)
    })

    // }
    // else{
    //   console.log("Email is not verified")
    //   response.status(403).send("Your email id is not verified yet")
    // }

  }).catch(function (error) {
    // Handle Errors here.
    var errorCode = error.code
    var errorMessage = error.message
    // ...
    console.log("Error recieved " + errorMessage)
    response.status(errorCode).send("Error occurred")
  });
});


exports.signOut = functions.https.onRequest((request, response) => {
  firebase.auth().signOut().then(function () {
    console.log('Signed Out')
    response.status(200).send()
  }, function (error) {
    response.status(401).send()
    console.error('Sign Out Error', error)
  })
})

const isLoggedIn = (token, callback) => {
  console.log("Method called with token " + token)
  const tokenVerificationFlag = admin.auth().verifyIdToken(token)

  const isLoggedInFlag = tokenVerificationFlag.then(function (decodedToken) {
    console.log("Inside success for callback"+callback)
    // var uid = decodedToken.uid;
    // ...
    console.log(token)
    console.log(decodedToken)
    callback(true)
    return
  }).catch(function (error) {
    // Handle error
    console.log("Recieved error for callback"+callback)
    callback(false)
    // return false
  })
}

// exports.createTraining = functions.https.onRequest((request, response) => {
//   console.log("Printing the token " + request.headers.authorization)
//   console.log("After splitting the Bearer >>" + request.headers.authorization.split('Bearer ')[1])

//   console.log("Printing header")
//   console.log("Printing header "+request.headers.authorization)
//   isLoggedIn(request.headers.authorization.split('Bearer ')[1], function (returnValue) {
//     console.log("Executing with value " + returnValue)
//     if (returnValue == true) {
      // console.log("from index.js "+request.body.trainingTitle)
      // var trainingModule = new TrainingModule(request.body)
      // response.status(200).send(trainingModule)
//     }
//     else {
//       response.status(401).send("Permission Denied. unauthorised access")
//     }
//   })
// })


exports.createTraining = functions.https.onRequest((request, response) => {

  isLoggedIn(request.headers.authorization.split('Bearer ')[1], function (returnValue) {
    console.log("Executing with value " + returnValue)
    if (returnValue == true) {
      // console.log("from index.js "+request.body.trainingTitle)
      var trainingModule = new TrainingModule(admin)
      trainingModule.newTraining(request.body,function(trainingID,status){
        console.log("Inside createTraining callback"+trainingID+status)
        response.status(status).send(trainingID)
      })
      
    }
    else {
      response.status(401).send("Permission Denied. unauthorised access")
    }
  })

})

exports.getTraining = functions.https.onRequest((request, response) => {
  console.log("Printing the token " + request.headers.authorization)
  console.log("After splitting the Bearer >>" + request.headers.authorization.split('Bearer ')[1])
  //Get the training id to fetch the details ...
  var trainingID = request.query.trainingId
  console.log("Printing training id " + trainingID)

  isLoggedIn(request.headers.authorization.split('Bearer ')[1], function (returnValue) {
    console.log("Executing with value " + returnValue)
    if (returnValue == true) {
      var rootRef = admin.database().ref("/training_detail/" + trainingID)
      rootRef.on("value", function (snapshot) {
        console.log("Priniting objects ..." + snapshot)
        response.status(200).send(snapshot.val())
      }, function (error) {
        console.log("Error: " + error.code)
      })
    }
    else {
      response.status(401).send("Permission Denied. unauthorised access")
    }
  })


})


exports.getTrainings = functions.https.onRequest((request, response) => {
  console.log("Printing the token " + request.headers.authorization)
  console.log("After splitting the Bearer " + request.headers.authorization.split('Bearer ')[1])

  isLoggedIn(request.headers.authorization.split('Bearer ')[1], function (returnValue) {
    console.log("Executing with value " + returnValue)
    if (returnValue == true) {
      var rootRef = admin.database().ref("/trainings")
      rootRef.on("value", function (snapshot) {
        console.log("Priniting objects ..." + snapshot)

        //Build an array and add each training object as a dictionary ...
        var trainingsArray = []
        snapshot.forEach(function (childSnapshot) {
          console.log("Inside for each" + snapshot)
          var snapshotKey = childSnapshot.key
          var childData = childSnapshot.val()
          trainingsArray.push(childData)
        });
        console.log("Training Array " + trainingsArray)

        response.status(200).send(trainingsArray)
      }, function (error) {
        console.log("Error: " + error.code)
      })
    }
    else {
      response.status(401).send("Permission Denied. unauthorised access")
    }
  })

})

