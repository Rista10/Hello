

import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/models/userModel.dart';
import 'package:chat_app/widgets/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/chatRoomModel.dart';

class ChatPage extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatRoom;
  final UserModel userModel;
  final User firebaseUser;

  const ChatPage(
      {super.key,
      required this.targetUser,
      required this.chatRoom,
      required this.userModel,
      required this.firebaseUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[400],
        title: Row(
          children: [
            CircleAvatar(child: Icon(Icons.camera_alt)),
            SizedBox(width: 15),
            Text(widget.targetUser.fullName!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 23,
                )),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chatrooms')
                    .doc(widget.chatRoom.chatRoomId)
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot datasnapShot =
                          snapshot.data as QuerySnapshot;
                      return ListView.builder(
                        itemCount: datasnapShot.docs.length,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(
                              datasnapShot.docs[index].data()
                                  as Map<String, dynamic>);
                          return Text(currentMessage.text.toString());
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              'An error occured!Please check your internet connection'));
                    } else {
                      return Center(child: Text('Say Hi to your new friend'));
                    }
                  } else {
                    return Center(child: Text('Firebase not connected'));
                  }
                }),
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
            messageTextField(
              text: 'Type messages here....',
              messageController: messageController,
              userModel: widget.userModel,
              chatRoom: widget.chatRoom,
            ),
          ],
        )
      ]),
    );
  }
}
