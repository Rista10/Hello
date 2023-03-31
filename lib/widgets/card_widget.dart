import 'package:chat_app/models/chatRoomModel.dart';
import 'package:chat_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/chatRoom.dart';

class ChatCard extends StatefulWidget {
  final UserModel userModel;
  final ChatRoomModel chatRoomModel;
  final User firebaseUser;
  final UserModel targetUser;

  const ChatCard({super.key, required this.userModel, required this.chatRoomModel, required this.firebaseUser, required this.targetUser});

  

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ChatPage(
                chatRoom: widget.chatRoomModel,
                firebaseUser: widget.firebaseUser,
                userModel: widget.userModel,
                targetUser: widget.targetUser,
              );
            }),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(widget.userModel.fullName!),
          subtitle: Text(widget.chatRoomModel.lastMessage!),
          
        ),
      ),
    );
  }
}
