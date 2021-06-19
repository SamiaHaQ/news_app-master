import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/business_logic/models/user.dart';
import 'package:news_app/src/view/ui/bottom_navigation.dart';
import 'package:news_app/src/view/ui/home.dart';
import 'package:news_app/src/view/ui/signin.dart';

// firebase user data root url
const String USER_DATA = 'users';

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
  static FirebaseUser user;
  static String errorMessage;
  static bool userSignIn = false;
  static User userData;

  // check user is logged on or not
  static checkUserAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavHome();
          } else {
            return SignIn();
          }
        });
  }

  // create a new user
  static Future<bool> createNewUser(String email, password)async{
    try {
      var _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_authResult != null){
        user = _authResult.user;
        userSignIn = true;
        return true;
      }
    } catch (e){
      errorMessage = e.toString();
      return false;
    }
  }

  // upload user data to firebase
  static Future<bool> uploadUserData(String email, String uid, String userName)async{
    try {
      await _firestore.collection('users').document(uid).setData({
        'uid': uid,
        'user_name': userName,
        'email': email,
        });
      return true;
    } catch (e){
      errorMessage = e.toString();
      return false;
    }
  }

  // get user data from  firebase
  static Future<bool> loadUserData()async{
    try {
      await _firestore.collection("users").document(user.uid).get().then((value){
        userData = User(email: user.email, uid: user.uid, name: value.data['user_name']);
      });
      return true;
    } catch (e){
      errorMessage = e.toString();
      return false;
    }
  }

  // change user name from firebase
  static Future<bool> changeUserName(String name)async{
    try {
      await _firestore.collection("users").document(user.uid).updateData({
        'user_name' : name
      });
      return true;
    } catch (e){
      errorMessage = e.toString();
      return false;
    }
  }

  // Firebase sign in method
  static Future<bool> userSignInAuth(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => (value != null) ? user = value.user : user = null);
      return true;
    } catch (error){
      errorMessage = error.toString();
      return false;
    }
  }

  // Firebase forgot password method
  static Future<bool> userForgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (error){
      errorMessage = error.toString();
      return false;
    }
  }

  // sign out user
  static userSignOut(){
    FirebaseAuth.instance.signOut();
    user = null;
  }
}