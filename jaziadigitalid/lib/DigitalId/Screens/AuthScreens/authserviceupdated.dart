import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jaziadigitalid/DigitalId/Screens/AuthScreens/authservice.dart';
import 'package:jaziadigitalid/DigitalId/Screens/AuthScreens/loginwithGoogle.dart';
import 'package:jaziadigitalid/DigitalId/Screens/ChiefScreen/MainScreenChief.dart';
import 'package:jaziadigitalid/DigitalId/Screens/multistageform.dart';
import 'package:jaziadigitalid/DigitalId/Screens/profilepages/profmainscreen.dart';

class AuthServiceUpdated {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() async {
    auth.signOut();
    googleSignIn.signOut();
    print("User Signed Out");
  }

  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<Object>(
                stream: firestore
                    .collectionGroup("Vouched")
                    .where("uid", isEqualTo: auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ProfilePage();
                  } else {
                    return DIRegister();
                  }
                });
          } else {
            return Login();
            //print('Nothing');
          }
        });
  }
}
