import 'package:chat_app/authentication/authentication.dart';
import 'package:chat_app/models/userModel.dart';
import 'package:chat_app/screens/chatRoom.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/navBar.dart';
import 'package:chat_app/widgets/card_widget.dart';
import 'package:chat_app/widgets/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/firebaseHelper.dart';
import '../models/chatRoomModel.dart';

class Home extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  const Home({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
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
                if (result!.contains('success')) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Login())));
                }
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 27,
              ))
        ],
      ),
      drawer: NavBar(userModel: widget.userModel!, user: widget.firebaseUser!),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: SearchTextField(
                userModel: widget.userModel!,
                firebaseUser: widget.firebaseUser!,
                text: 'Search messages',
                searchController: searchController),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatrooms")
                    .where("participants.${widget.userModel?.uid}",
                        isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot chatRoomSnapshot =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        itemCount: chatRoomSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                              chatRoomSnapshot.docs[index].data()
                                  as Map<String, dynamic>);

                          Map<String, dynamic> participants =
                              chatRoomModel.participants!;

                          List<String> participantKeys =
                              participants.keys.toList();
                          participantKeys.remove(widget.userModel?.uid);

                          return FutureBuilder(
                            future: fireBaseHelper
                                .getUserModelById(participantKeys[0]),
                            builder: (context, userData) {
                              if (userData.connectionState ==
                                  ConnectionState.done) {
                                if (userData.data != null) {
                                  UserModel targetUser =
                                      userData.data as UserModel;

                                  return ChatCard(
                                      userModel: widget.userModel!,
                                      chatRoomModel: chatRoomModel,
                                      firebaseUser: widget.firebaseUser!,
                                      targetUser: targetUser);
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Center(
                        child: Text("No Chats"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            // ListView.builder(
            //     physics: BouncingScrollPhysics(),
            //     itemCount: 2,
            //     itemBuilder: ((context, index) {
            //       return ChatCard();
            //     })),
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
