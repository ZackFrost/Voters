import 'package:flutter/material.dart';
import 'package:voters/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(
    home:MyApp(),
    title: 'Voter Info',
    theme: ThemeData(
      accentColor: Colors.pink,
    ),
    debugShowCheckedModeBanner: false,
    )
  );


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loginPage();
  }


}

