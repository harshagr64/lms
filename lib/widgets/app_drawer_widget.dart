import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "sign_in.dart";
import "../screens/create_class_screen.dart";
import 'sign_in.dart';


class AppDrawer extends StatelessWidget {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('faculty_user')
          .doc(_user.uid)
          .get(),
      builder: (ctx, snapShot) {
        return Drawer(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1),
            child: snapShot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Column(
                        children: [
                          Container(
                              width: 80,
                              height: 80,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapShot.data['imageurl']),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapShot.data['username'].toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: ()=>signout(context),
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.add),
                        title: Text(
                          'Create Class',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                              letterSpacing: 0.3),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(CreateClassScreen.routeName);
                        },
                      ),
                      Divider(),
                      ListTile(
                          leading: Icon(Icons.group_add),
                          title: Text(
                            'Join Class',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[900],
                                letterSpacing: 0.3),
                          ),
                          onTap: () {}),
                    ],
                  ),
          ),
        );
      },
    );
  }
}