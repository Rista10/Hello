import 'package:chat_app/authentication/authentication.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/widgets/card_widget.dart';
import 'package:chat_app/widgets/textField.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[400],
        title: Text('Hello',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              letterSpacing: 3,
              fontSize: 25,
            )),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final result = await AuthService().SignOut();
                if(result!.contains('success'))
                {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => Login())));
                }
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 27,
              ))
        ],
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: searchTextField(text: 'Search messages'),
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 2,
                itemBuilder: ((context, index) {
                  return ChatCard();
                })),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber[400],
        child: Icon(Icons.chat),
      ),
    );
  }
}
