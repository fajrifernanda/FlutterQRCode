import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'device_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    DeviceinfoPage.tag: (context)=> DeviceinfoPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterQRCode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
