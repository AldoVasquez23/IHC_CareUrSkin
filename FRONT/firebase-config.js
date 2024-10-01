// firebase-config.js

// Your Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyDW7EYFd1LIxJAKO3SgB5DpnSEGfpvpMCo",
    authDomain: "careurskin-1555c.firebaseapp.com",
    projectId: "careurskin-1555c",
    storageBucket: "careurskin-1555c.appspot.com",
    messagingSenderId: "241785896436",
    appId: "1:241785896436:web:47bf2a8c43361dd1ad4da1",
    measurementId: "G-094X3TKWLH"
  };
  
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  
  // Get references to Firebase services
  const database = firebase.database();
  const auth = firebase.auth();
  