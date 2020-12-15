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
     API_URL+':'+PORT+'/user/api/',
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
// bool _autovalidateMode=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        title: Text('ShopVia App',style: TextStyle(color:Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
       
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(

          autovalidateMode: AutovalidateMode.always,
            key: _formKey,
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
                TextFormField(
                  controller: firstnamecontroller,
                  textAlign: TextAlign.center,
                  validator: (value){
                    if(value.length==0)
                      return 'Enter Your First Name';
                    else  
                      return null;
                  },
                  onSaved: (String val) {
                      this.setState(() {firstname=val;});
                  },

                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter your FirstName'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: lastnamecontroller,
                  textAlign: TextAlign.center,
                  validator: (value){
                    if(value.length==0)
                      return 'Enter Your LastName';
                    else  
                      return null;
                  },
                  onSaved: (String val) {
                      this.setState(() {lastname=val;});
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter your LastName'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailcontroller,
                  textAlign: TextAlign.center,
                   validator: (value){
                    Pattern pattern=r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp=new RegExp(pattern);
                    if(!regExp.hasMatch(value))
                      return 'Enter Valid Email';
                    else  
                      return null;
                  },
       onSaved: (String val) {
                      this.setState(() {email=val;});
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  validator: (value){
                    if(value.length==0)
                      return 'Enter Your Password';
                    else  
                      return null;
                  },
                  onSaved: (String val) {
                      this.setState(() {password=val;});
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(height: 35),
               Builder(
                  builder:(context) => RoundedButton(
                  onpress: ()async{

if(_formKey.currentState.validate())
                    { 
                      _formKey.currentState.save();
                           var result=await register(firstname,lastname,email,password);
                      print(json.decode(result.body).toString());

                      if((json.decode(result.body)['id']!=null))
                          {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('User Created Successfully ==> Login with Provided Credentials')));

                          Timer(Duration(seconds: 1), () {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>LoginScreen()));
    });                       
                          }       
                        else
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Could Not Complete Registration'+json.decode(result.body).toString())));
                    }
                    else{
                    // this.setState(() {_autovalidateMode=true;});
                    }

            
                  },

                  title: 'Registration',
                  colour: Colors.lightBlueAccent,
                ),),
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
      ),
    );
  }
}
