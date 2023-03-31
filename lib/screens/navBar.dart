import 'package:chat_app/models/firebaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/userModel.dart';

class NavBar extends StatelessWidget {
  final UserModel userModel;
  final User user;
 
const NavBar({super.key, required this.userModel, required this.user});
  @override
  Widget build(BuildContext context) {
   
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Colors.amber,
              ),
              accountName:Text(userModel.fullName!,
              style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                     color: Colors.white,
                  )),
               accountEmail: Text(userModel.email!,
               style: TextStyle(
                    color: Colors.white
                  )
               ),
               currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/59/37/5f/59375f2046d3b594d59039e8ffbf485a.jpg'),
                  radius: 1),
          
               ),
               
 ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text('Account Settings',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 17,
                  )),
                  trailing: Icon(Icons.keyboard_arrow_right),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.help, color: Colors.black),
              title: Text('Help',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 17,
                  )),
                  trailing: Icon(Icons.keyboard_arrow_right),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.report_problem, color: Colors.black),
              title: Text('Report a problem',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 17,
                  )),
                  trailing: Icon(Icons.keyboard_arrow_right),
            ),    
        ],
      ),
    );
  }
}
