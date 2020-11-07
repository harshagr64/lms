import "package:flutter/material.dart";
import "../widgets/create_class_form_widget.dart";
import 'package:lms/widgets/app_drawer_widget.dart';


class CreateClassScreen extends StatelessWidget {
  static const routeName = 'create-class';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(child: null, preferredSize: Size.fromWidth(width)),
      appBar: AppBar(
        
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Classroom",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: CreateForm(),
      ),
      drawer: AppDrawer(),
    );
  }
}
