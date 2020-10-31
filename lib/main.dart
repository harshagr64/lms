import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:lms/screens/demo.dart';
import "screens/auth_screen.dart";
import "package:firebase_auth/firebase_auth.dart";
import "screens/home_screen.dart";
import "screens/create_class_screen.dart";
import "package:flutter_statusbarcolor/flutter_statusbarcolor.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFFFFFF));
    return MaterialApp(
      title: 'LMS',
      debugShowCheckedModeBanner: false,
      home: Demo(),
      routes: {
        CreateClassScreen.routeName: (ctx) => CreateClassScreen(),
      },
    );
  }
}
