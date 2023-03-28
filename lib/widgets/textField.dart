import 'package:chat_app/models/firebaseHelper.dart';
import 'package:chat_app/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String? text;
  final TextEditingController searchController;

  SearchTextField({required this.text, required this.searchController});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
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
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: widget.searchController.text)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                print(snapshot.data);
                QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                print(dataSnapshot.docs);
                if (dataSnapshot.docs.length > 0) {
                  Map<String, dynamic> userMap =
                      dataSnapshot.docs[0].data() as Map<String, dynamic>;
                  UserModel searchedUser = UserModel.fromMap(userMap);
                  print(searchedUser);
                  print(searchedUser.address);
                  return ListTile(
                    textColor: Colors.black,
                    title: Text(searchedUser.fullName!),
                    subtitle: Text(searchedUser.email!),
                  );
                } else {
                  return ListTile(title: Text('No results found'));
                }
              } else if (snapshot.hasError) {
                return ListTile(title: Text('An error occurred'));
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}

// searchTextField(
//     {required String? text, required TextEditingController searchController}) {
//   return Column(
//     children: [
//       TextField(
//         controller: searchController,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           prefixIcon: IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {},
//           ),
//           hintText: text,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//       StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .where('email', isEqualTo: searchController.text)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData) {
//               QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
//               if (dataSnapshot.docs.length > 0) {
//                 Map<String, dynamic> userMap =
//                     dataSnapshot.docs[0].data() as Map<String, dynamic>;
//                 UserModel searchedUser = UserModel.fromMap(userMap);
//                 return ListTile(
//                   title: Text(searchedUser.fullName!),
//                   subtitle: Text(searchedUser.email!),
//                 );
//               }
//             } else if (snapshot.hasError) {
//               return ListTile(title: Text('An error occured'));
//             } else {
//               return ListTile(title: Text('No results found'));
//             }
//           } else {
//             CircularProgressIndicator();
//           }
//         },
//       ),
//     ],
//   );
// }

messageTextField({required String? text}) {
  return Padding(
    padding: const EdgeInsets.all(18),
    child: TextField(
        decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      suffixIcon: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.send,
          color: Colors.amber,
        ),
      ),
      hintText: text,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    )),
  );
}
