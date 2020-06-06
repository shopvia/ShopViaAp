import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopvia/Constants.dart';
import 'package:shopvia/components/roundButton.dart';
// import 'package:shopvia/home_page.dart';
import 'package:shopvia/screens/registration_screen.dart';

// Future<LoginScreen> fetchUser() async{
//   final response = await http.get(
//     'http://192.168.1.3:8000/user/api/2',
//     // Send authorization headers to the backend.
//     headers: {HttpHeaders.authorizationHeader: "4baa20d64b8f0e454a4858bbe552659996b1389b"},
//   );

//   final responseJson = json.decode(response.body);
  
//   return User.fromJson(responseJson);
// }


Future<http.Response> login(String username,String password) async{
  var credentials={
    'username': username,
    'password':password
  };
  http.Response response = await http.post(
    'http://192.168.1.2:8000/user/api/',
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body:json.encode(credentials)
  );
  print(response.body);
  return response;
}

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username, password;
final   TextEditingController _usernameController=new TextEditingController() ;
 final TextEditingController _passwordController=new TextEditingController();
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
            TextFormField(
              controller: _usernameController,
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),

            ),
            SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter Your Password'),
            ),
            SizedBox(height: 48),
            RoundedButton(
              onpress: () {

               this.setState(() {this.username=this._usernameController.text;});
               this.setState(() {this.password=this._passwordController.text;});
                print("Credentials:"+username+" "+password);
               print(login(username,password));

            //     Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyHomePage(),
            // ));


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
