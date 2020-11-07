import "package:flutter/material.dart";
import '../widgets/app_drawer_widget.dart';
import "create_class_screen.dart";
import "../widgets/class_list_widget.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(CreateClassScreen.routeName),
            ),
          ],
        ),
        body: ClassListWidget());
  }
}
