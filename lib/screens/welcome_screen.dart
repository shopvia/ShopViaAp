import 'package:flutter/material.dart';
import 'package:shopvia/components/roundButton.dart';
import 'package:shopvia/screens/login_screen.dart';
import 'package:shopvia/screens/registration_screen.dart';

class WelecomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelecomeScreenState createState() => _WelecomeScreenState();
}

class _WelecomeScreenState extends State<WelecomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text('ShopVia')),
          backgroundColor: Colors.cyan,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            //     Container(
            //       child: new DecoratedBox(
            //   decoration: new BoxDecoration(
            //     image: new DecorationImage(
            //       image: new AssetImage("lib/assets/background.jpeg"),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
                  
            //     ),
                
                RoundedButton(
                  title: "Sign Up",
                  colour: Colors.lightBlueAccent,
                  onpress: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );
                    //for developing purpose   
                    // Navigator.pushNamed(context, Login_screen.id);
                  },
                ),
                SizedBox(height: 4),
                RoundedButton(
                  title: "Login",
                  colour: Colors.lightBlueAccent,
                  onpress: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())
                    );
                  },
                ),

              ],
            ),
          ),
        ));
  }
}
