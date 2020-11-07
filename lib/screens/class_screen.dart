import 'package:flutter/material.dart';
import "upload_screen.dart";
import '../widgets/app_drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClassScreen extends StatelessWidget {
  static const routeName = '/classscreen';
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore _instance = FirebaseFirestore.instance;
    final classid = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Classroom',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _instance
            .collection('newclass')
            .doc(user.uid)
            .collection('totalclass')
            .doc(classid)
            .get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.blue[50],
                  width: double.infinity,
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SEM- ${snapshot.data['sem'].toString()}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SECTION- ${snapshot.data['section']}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Text('hello');
                    },
                    itemCount: 2,
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(UploadScreen.routeName, arguments: classid),
        tooltip: 'Upload',
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        elevation: 5,
      ),
    );
  }
}
