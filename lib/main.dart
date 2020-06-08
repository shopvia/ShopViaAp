import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopvia/screens/homepage_screen.dart';
import 'package:shopvia/screens/login_screen.dart';

void main() async{
  SharedPreferences.setMockInitialValues({});
  Widget _show=LoginScreen();

  SharedPreferences prefs=await SharedPreferences.getInstance();
  String result=await(prefs.getString('token'));
  if(await result!=null)
  {
    _show=HomePageScreen();
  }
  
    runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFDBDFF4),
          scaffoldBackgroundColor: Color(0xFFDBDFF4),
        ),
        home: _show 
        )
    );
  }