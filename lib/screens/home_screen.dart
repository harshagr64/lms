import "package:flutter/material.dart";
import '../widgets/app_drawer_widget.dart';
import "package:cloud_firestore/cloud_firestore.dart";


class HomeScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawerWidget(),
      body: Center(
        child: Text("hello"),
      ),
    );
  }
}
