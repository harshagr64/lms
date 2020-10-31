import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "sign_in.dart";
import "../screens/create_class_screen.dart";

class AppDrawerWidget extends StatelessWidget {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final User _user = FirebaseAuth.instance.currentUser;

  int _check = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection(_user.email.startsWith(RegExp(r'[0-9]'))
              ? 'studentusers'
              : 'facultyusers')
          .doc(_user.uid)
          .get(),
      builder: (ctx, snapShot) {
        return Drawer(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.09),
            child: snapShot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapShot.data['imageUrl']),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapShot.data['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.blue[50],
                            child: Text(
                              'Logout',
                              style:
                                  TextStyle(fontSize: 15, letterSpacing: 0.5),
                            ),
                            onPressed: signOut,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      ListTile(
                        focusColor: _check==1 ?  Colors.blue : Colors.white,
                        leading: Icon(Icons.add),
                        title: Text(
                          "Create Class",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                        onTap: () {
                          _check = 1;
                          Navigator.of(context).pushReplacementNamed(
                              CreateClassScreen.routeName);
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.group_add),
                        title: Text(
                          "Join Class",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
