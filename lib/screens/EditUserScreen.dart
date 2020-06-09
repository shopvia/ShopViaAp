import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopvia/Constants.dart';
import 'package:shopvia/components/roundButton.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shopvia/screens/login_screen.dart';

Future<http.Response> editUser(String firstname,String lastname) async{
   SharedPreferences prefs=await SharedPreferences.getInstance();
  String token=prefs.getString('token').toString();
  String id=prefs.getString('id').toString();
  var userdetail={
    'first_name': firstname,
    'last_name':lastname
  };
  http.Response response = await http.patch(
     API_URL+':'+PORT+'/user/api/'+id+'/',
    headers: {HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader:"Token "+token
    },
    body:json.encode(userdetail)
  );
  return response;
}

getLastName() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastname=prefs.getString('last_name') ?? 'No Last Name';
    return lastname;
}
getFirstName() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstname=prefs.getString('first_name') ?? 'No First Name';
    return firstname;
}
class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  bool _autovalidate=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String firstname,lastname,email,password;
  TextEditingController firstnamecontroller=new TextEditingController();
  TextEditingController lastnamecontroller=new TextEditingController();
@override
  void initState() {
    super.initState();
    getFirstName().then((result)
{
 setState(() {
      firstname=result;
    });
});
    getLastName().then((result)
{
 setState(() {
      lastname=result;
    });
});
  }
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

          autovalidate: _autovalidate,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Edit Details',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        )
                        ), 
                        SizedBox(height: 20),
                TextFormField(
                  controller: firstnamecontroller..text=firstname,
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
                  controller: lastnamecontroller..text=lastname,
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
                
                SizedBox(height: 35),
               Builder(
                  builder:(context) => RoundedButton(
                  onpress: ()async{

              if(_formKey.currentState.validate())
                    { 
                      _formKey.currentState.save();
                      print("FirstName: "+firstname);
                      print("LastName: "+lastname);
                      var result=await editUser(firstname,lastname);
                      print(json.decode(result.body).toString());
                 
                      if((json.decode(result.body)['id']!=null))
                          {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('User Edited Successfully')));
                            final prefs=await SharedPreferences.getInstance();
                             prefs.setString('first_name', json.decode(result.body)['first_name']);
                             prefs.setString('last_name', json.decode(result.body)['last_name']);
                            
                          }       
                        else
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Could Not Edit User'+json.decode(result.body).toString())));
                    }
                    else{
                    this.setState(() {_autovalidate=true;});
                    }
                  },

                  title: 'Submit',
                  colour: Colors.lightBlueAccent,
                ),),
           
                        
              ],
            ),
          ),
        ),
      ),
    );
  }
}