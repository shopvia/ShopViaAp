import 'package:flutter/material.dart';
import 'package:shopvia/Constants.dart';
import 'package:shopvia/components/roundButton.dart';
import 'package:flutter/gestures.dart';
import 'package:shopvia/screens/login_screen.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<http.Response> register(String firstname,String lastname,String email, String password) async{
  var userdetail={
    'first_name': firstname,
    'last_name':lastname,
    'email':email,
    'password':password
  };
  http.Response response = await http.post(
    'http://192.168.254.5:8000/user/api/',
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body:json.encode(userdetail)
  );
  return response;
}

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String firstname,lastname,email,password;

  TextEditingController firstnamecontroller=new TextEditingController();
  TextEditingController lastnamecontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passwordcontroller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('ShopVia - Sign Up'),
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
                controller: firstnamecontroller,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your FirstName'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: lastnamecontroller,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your LastName'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailcontroller,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordcontroller,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(height: 35),
              RoundedButton(
                onpress: ()async{

               this.setState(() {this.firstname=this.firstnamecontroller.text;});
               this.setState(() {this.lastname=this.lastnamecontroller.text;});
               this.setState(() {this.email=this.emailcontroller.text;});
               this.setState(() {this.password=this.passwordcontroller.text;});
                
              var result=await register(firstname,lastname,email,password);
              //  print(result);
                },
            //     Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomePageScreen(),
            // ));

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
