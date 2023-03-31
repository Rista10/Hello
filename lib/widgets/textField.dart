import 'package:chat_app/main.dart';
import 'package:chat_app/models/chatRoomModel.dart';
import 'package:chat_app/models/firebaseHelper.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/models/userModel.dart';
import 'package:chat_app/screens/chatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String? text;
  final TextEditingController searchController;
  final UserModel userModel;
  final User firebaseUser;

  const SearchTextField(
      {super.key,
      this.text,
      required this.searchController,
      required this.userModel,
      required this.firebaseUser});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${widget.userModel.uid}', isEqualTo: true)
        .where('participants.${targetUser.uid}', isEqualTo: true)
        .get();
    if (snapshot.docs.length > 0) {
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatRoom;
      print('Chatroom already created');
    } else {
      ChatRoomModel newChatroom =
          ChatRoomModel(chatRoomId: uuid.v1(), lastMessage: '', participants: {
        widget.userModel.uid.toString(): true,
        targetUser.uid.toString(): true,
      });
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(newChatroom.chatRoomId)
          .set(newChatroom.toMap());
      print('New chatroom created');
      chatRoom = newChatroom;
    }
    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {});
              },
            ),
            hintText: widget.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (widget.searchController.text
            .isNotEmpty) // Check if searchController text is not empty
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: widget.searchController.text)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                  if (dataSnapshot.docs.length > 0) {
                    Map<String, dynamic> userMap =
                        dataSnapshot.docs[0].data() as Map<String, dynamic>;
                    UserModel searchedUser = UserModel.fromMap(userMap);

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: Colors.white,
                          textColor: Colors.black,
                          title: Text(searchedUser.fullName!),
                          subtitle: Text(searchedUser.email!),
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () async {
                            ChatRoomModel? chatroomModel =
                                await getChatroomModel(searchedUser);
                            if (chatroomModel != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            targetUser: searchedUser,
                                            chatRoom: chatroomModel,
                                            userModel: widget.userModel!,
                                            firebaseUser: widget.firebaseUser!,
                                          )));
                            }
                          }),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                      child: ListTile(title: Text('No results found')),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                    child: ListTile(title: Text('An error occurred')),
                  );
                } else {
                  return Container();
                }
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
      ],
    );
  }
}

class messageTextField extends StatefulWidget {
  final String? text;
  final TextEditingController messageController;
  final UserModel userModel;
  final ChatRoomModel chatRoom;

  const messageTextField(
      {super.key,
      this.text,
      required this.messageController,
      required this.userModel,
      required this.chatRoom});

  @override
  State<messageTextField> createState() => _messageTextFieldState();
}

class _messageTextFieldState extends State<messageTextField> {
  void sendMessage() async {
    String msg = widget.messageController.text.trim();
    if (msg != null) {
      MessageModel newMessage = MessageModel(
        messageId: uuid.v1(),
        sender: widget.userModel.uid,
        text: msg,
        createdOn: DateTime.now(),
        seen: false,
      );

      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatRoom.chatRoomId)
          .collection('messages')
          .doc(newMessage.messageId)
          .set(newMessage.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: TextField(
        maxLines: null,
          controller: widget.messageController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            suffixIcon: IconButton(
              onPressed: () {},
              icon: IconButton(
                onPressed: () {
                  sendMessage();
                  print('Message sent');
                },
                icon: Icon(Icons.send),
                color: Colors.amber,
              ),
            ),
          
            hintText: widget.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          )),
    );
  }
}
