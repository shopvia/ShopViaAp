import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopvia/Constants.dart';
import 'package:shopvia/components/roundButton.dart';
import 'package:shopvia/home_page.dart';
import 'package:shopvia/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('ShopVia'),
        ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                      ),
            ),
            SizedBox(height: 50),
            TextField(
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
            ),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter Your Password'),
            ),
            SizedBox(height: 48),
            RoundedButton(
              onpress: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(),
            ));
              },
              title: 'Login',
              colour: Colors.lightBlueAccent,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Forget Password?',
                  style: TextStyle(color:Colors.grey),
    children: <TextSpan>[
      TextSpan(text: 'Create An Account', style: TextStyle( fontWeight: FontWeight.bold,color: Colors.cyan),
       recognizer: TapGestureRecognizer()
          ..onTap = () {
              print("Tapped Sign Up");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));           // single tapped
          },
  
      )],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
