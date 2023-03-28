

import 'package:chat_app/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<UserCredential?> SignIn(
      {required String emailText, required String passwordText}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailText, password: passwordText);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String?> CreateAccount({
    required String name,
    required String emailText,
    required String numberText,
    required String addressText,
    required String passwordText,
  }) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailText, password: passwordText);

      if (user != null) {
        String uid = user.user!.uid;
        UserModel newUser = UserModel(
          uid: uid,
          email: emailText,
          address: addressText,
          fullName: name,
          number: numberText,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(newUser.toMap())
            .then((value) => 'New user created');
        return 'success';
      }
    } catch (e) {
      print('error');
      return 'error adding user';
    }
  }

  Future<String?> Reset({required String emailId}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailId);
      return 'success';
    } catch (e) {
      throw e;
    }
  }

  Future<String?> SignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return 'success';
    } catch (e) {
      return 'error';
    }
  }
}
