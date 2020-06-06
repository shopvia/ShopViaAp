import 'package:flutter/material.dart';
import 'package:shopvia/Constants.dart';
import 'package:shopvia/components/roundButton.dart';
import 'package:flutter/gestures.dart';
import 'package:shopvia/screens/login_screen.dart';



class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('ShopVia'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
       
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                      )
                      ), 
                      SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your FirstName'),
              ),
              SizedBox(height: 10),
              TextField(
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your LastName'),
              ),
              SizedBox(height: 10),
              TextField(
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(height: 35),
              RoundedButton(
                onpress: () {},
                title: 'Registration',
                colour: Colors.lightBlueAccent,
              ),
          Center(
            child: RichText(
  text: TextSpan(
    text: 'Already Have an Account  ',
    style: TextStyle(color:Colors.grey),
    children: <TextSpan>[
      TextSpan(text: 'Sign In', style: TextStyle( fontWeight: FontWeight.bold,color: Colors.cyan),
       recognizer: TapGestureRecognizer()
          ..onTap = () {
            print("Tapped Sign In");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));           // single tapped
          },
  
      )],
  ),
),
          )
                      
            ],
          ),
        ),
      ),
    );
  }
}
