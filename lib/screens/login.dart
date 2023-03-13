import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            height: mq.height * .45,
            width: mq.width * .8,
            top: mq.height * .2,
            left: mq.width * .11,
            child: Image.asset('images/chat.png'),
          ),
          Positioned(
            top: mq.height * .63,
            left: mq.width * .4,
            child: Text('Hello',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.amber,
                  letterSpacing: 3,
                  fontSize: 35,
                )),
          ),
          Positioned(
            top: mq.height * .72,
            left: mq.width * .21,
            child: Container(
              height: mq.height * .05,
              width: mq.width * .6,
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton.icon(
                icon: Icon(Icons.login_rounded, color: Colors.white,),
                onPressed: () async{
               
                },
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
