import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  static Future registerUser(
      {@required String? email, @required String? password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      print("ERROR===>>$e");
      print("*************************");
    }
  }

  static Future loginUser(
      {@required String? email, @required String? password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      print("ERROR===>>$e");
    }
  }

  static Future signOut(
      {@required String? email, @required String? password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      print("ERROR===>>$e");
    }
  }
}
