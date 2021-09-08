import 'package:flutter/material.dart';
import 'package:xiaobei/page/app.dart';
import 'package:xiaobei/page/console/health.dart';
import 'package:xiaobei/page/login/login.dart';
import 'r.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      routes: {

        "/":(context)=>AppHome(),
        "/login":(context)=>LoginPage(),
        "/console/health":(context)=>HealthPage(),
      },
      initialRoute: "/",
    );
  }
}


