import 'package:chat_app/models/firebaseHelper.dart';
import 'package:chat_app/models/userModel.dart';
import 'package:chat_app/screens/chatRoom.dart';
import 'package:chat_app/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    UserModel? thisUserModel = await fireBaseHelper.getUserModelById(user.uid);
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelloLoggedIn(userModel: thisUserModel, firebaseUser: user)
    ));
  } else {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Hello(),
    ));
  }
}

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class HelloLoggedIn extends StatelessWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  const HelloLoggedIn(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Home(userModel: userModel, firebaseUser: firebaseUser);
  }
}
