import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopvia/Constants.dart';
import 'package:shopvia/components/roundButton.dart';
import 'package:shopvia/screens/homepage_screen.dart';
import 'package:shopvia/screens/registration_screen.dart';

Future<http.Response> login(String username,String password) async{
  var credentials={
    'username': username,
    'password':password
  };
  http.Response response = await http.post(
    API_URL+':'+PORT+'/api/auth-token',
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body:json.encode(credentials)

    );
  return response;
}

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username, password;
  bool _autovalidate=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final   TextEditingController _usernameController=new TextEditingController() ;
 final TextEditingController _passwordController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('ShopVia App',style: TextStyle(color:Colors.white),),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            autovalidate: _autovalidate,
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

                TextFormField(
                  controller: _usernameController,
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
                      this.setState(() {username=val;});
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),

                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                    validator: (value){
                    if(value.length==0)
                      return 'Enter Your Password';
                    else  
                      return null;
                  },
                  onSaved: (String val) {
                      this.setState(() {password=val;});
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Password'),
                ),
                SizedBox(height: 40),
                
                Builder(
                  builder:(context) =>RoundedButton(
                  onpress: () async{
                    if(_formKey.currentState.validate())
                    { 
                      _formKey.currentState.save();
                      print("Credentials:"+this.username+" "+this.password);
                      var result=await login(username,password);
                      print(json.decode(result.body).toString());

                      if((json.decode(result.body)['token']!=null))
                          {
                            
                              
                            final prefs=await SharedPreferences.getInstance();
                            await prefs.setString('token', json.decode(result.body)['token']);
                            print("Token is: "+prefs.getString('token'));
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Logged In Successfully => Taking you to HomePage')));
                                                    Timer(Duration(seconds: 1), () {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>HomePageScreen()));
    });                                                }       
                        else
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Invalid Login Credentials')));
                    }
                    else{
                    this.setState(() {_autovalidate=true;});
                    }
                    // print("Credentials:"+this.username+" "+this.password);
                   
                  // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Are you talkin\' to me?')));
                  //  this.(context).showSnackBar(SnackBar(content: Text('asdasd')));
                
                //     Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePageScreen(),
                // ));


                  },
                  title: 'Login',
                  colour: Colors.lightBlueAccent,
                ),
                ),

                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Dont Have an Account?',
                      style: TextStyle(color:Colors.grey),
    children: <TextSpan>[
        TextSpan(text: ' Sign Up', style: TextStyle( fontWeight: FontWeight.bold,color: Colors.cyan),
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
        ),
      ),
    );
  }
}