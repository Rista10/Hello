import 'package:chat_app/authentication/authentication.dart';
import 'package:chat_app/screens/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[400],
        title: Text('Welcome to Hello',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 22,
            )),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
                radius: 65,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Colors.white,
                    )),
                backgroundColor: Colors.blue),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(27, 12, 27, 12),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(27, 12, 27, 12),
            child: TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                hintText: 'Phone number',
              ),
            
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(27, 12, 27, 12),
            child: TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Address',
              ),
         
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(27, 12, 27, 12),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(27, 12, 27, 12),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(12)),
              child: TextButton.icon(
                onPressed: () async {
                  final result = await AuthService().CreateAccount(
                      name: nameController.text,
                      emailText: emailController.text,
                      numberText: numberController.text,
                      addressText: addressController.text,
                      passwordText: passwordController.text);
                  if (result!.contains('success')) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }
                },
                icon: Icon(
                  Icons.login_rounded,
                  color: Colors.white,
                ),
                label: Text(
                  'Sign up',
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
