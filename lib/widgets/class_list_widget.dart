import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "../screens/class_screen.dart";

class ClassListWidget extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _instance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _instance
          .collection('newclass')
          .doc(user.uid)
          .collection('totalclass')
          .orderBy('createdate', descending: true)
          .get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                ClassScreen.routeName,
                arguments: snapshot.data.documents[index]['classid'],
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue[100],
                  border: Border.all(width: 1, color: Colors.blue[100]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data.documents[index]['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SEM- ${snapshot.data.documents[index]['sem'].toString()}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          snapshot.data.documents[index]['date'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'SECTION- ${snapshot.data.documents[index]['section']}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: snapshot.data.documents.length,
          ),
        );
      },
    );
  }
}
