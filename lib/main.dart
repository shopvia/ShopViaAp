import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopvia/screens/homepage_screen.dart';
// import 'package:shopvia/screens/login_screen.dart';

void main() async{

  Widget _show=HomePageScreen();

  //Putthing this Logic at HomePage
  // SharedPreferences.setMockInitialValues({});
  // SharedPreferences prefs=await SharedPreferences.getInstance();
  // String result=prefs.getString('token');
  
  // print("Token at main: "+result.toString());
  // if(result!=null)
  // {
  //   _show=HomePageScreen();
  // }
  
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