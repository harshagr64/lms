import 'package:flutter/material.dart';
import "../widgets/upload_form_widget.dart";
import "../widgets/app_drawer_widget.dart";

class UploadScreen extends StatelessWidget {
  static const routeName = '/uploadscreen';

  @override
  Widget build(BuildContext context) {
    final classId = ModalRoute.of(context).settings.arguments;
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
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Container(
          padding: EdgeInsets.all(8),
          child: UploadFormWidget(classId),
        ),
      ),
    );
  }
}
