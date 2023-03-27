import 'package:chat_app/widgets/textField.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[400],
        title: Text('Username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 25,
            )),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            
          ),
        ),
        Stack(
        children: [
           Container(
            height: 100,
            width: double.infinity,
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
             color: Colors.white,
           ),
          ),
          messageTextField(text: 'Type messages here....'),
        ],
        )
      ]),

    );
  }
}
