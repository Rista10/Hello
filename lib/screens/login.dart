import 'package:chat_app/authentication/authentication.dart';
import 'package:chat_app/screens/createAccount.dart';
import 'package:chat_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            height: mq.height * .45,
            width: mq.width * .8,
            top: mq.height * .15,
            left: mq.width * .11,
            child: Image.asset('images/chat.png'),
          ),
          Positioned(
            top: mq.height * .58,
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
            top: mq.height * .68,
            left: mq.width * .16,
            child: Column(
              children: [
                Container(
                  height: mq.height * .05,
                  width: mq.width * .7,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: mq.height * .05,
                  width: mq.width * .7,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: mq.height * .05,
                  width: mq.width * .6,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.login_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final result = await AuthService().SignIn(
                          emailText: emailController.text,
                          passwordText: passwordController.text);
                      if (result!.contains('success')) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context)=>Home()));
                      }
                    },
                    label: Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Create an account:',
                        style: TextStyle(
                          color: Colors.brown[400],
                          fontSize: 15,
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text('Sign up',
                          style: TextStyle(
                            color: Colors.brown[400],
                            fontSize: 15,
                          )),
                    ),
              ],),],
            ),
          )
        ],
      ),
    );
  }
}
