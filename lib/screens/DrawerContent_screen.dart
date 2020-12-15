import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopvia/screens/EditUserScreen.dart';
import 'package:shopvia/screens/aboutscreen.dart';
import 'package:shopvia/screens/login_screen.dart';

getUsername() async{
  String username='';
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstname=prefs.getString('first_name') ?? 'No First Name';
    String lastname=prefs.getString('last_name') ?? 'No Last Name';
    username=firstname+' '+lastname;
    // username=prefs.getString('token') ?? 'No Token';
    return username;
}
getEmail() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
    String email=prefs.getString('email') ?? 'No email';
    return email;
}

class Drawercontent extends StatefulWidget {
  @override
  _DrawercontentState createState() => _DrawercontentState();
}
class _DrawercontentState extends State<Drawercontent> {
  String username;
  String email;

  @override
  void initState() {

    getUsername().then((result)
    {
    setState(() {
          username=result;
        });
    });
    getEmail().then((result)
    {
    setState(() {
          email=result;
        });
    });

        super.initState();

   
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //header
          UserAccountsDrawerHeader(
            arrowColor: Colors.deepPurpleAccent,
            // accountName: Text('sdasd'),
            accountName: Text(username??'User Name'),
            accountEmail: Text(email?? 'Email'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal[500],
            ),
          ),
          //body
          // InkWell(
          //   onTap: () {
          //      Navigator.pushNamed(context, HomePageScreen.id);
          //   },
          //   child: ListTile(
          //     title: Text('Home'),
          //     leading: Icon(Icons.home),
          //   ),
          // ),

          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditUser())).then((__) {
                initState();
              });
            },
            child: ListTile(
              title: Text('Edit account'),
              leading: Icon(Icons.person),
            ),
          ),
         
         
          // InkWell(
          //   onTap: () {
          //     print('pressed');
          //   },
          //   child: ListTile(
          //     title: Text('My oder'),
          //     leading: Icon(Icons.shopping_basket),
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //   },
          //   child: ListTile(
          //     title: Text('Categories'),
          //     leading: Icon(Icons.dashboard),
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     print('pressed');
          //            },
          //   child: ListTile(
          //     title: Text('Filter Price'),
          //     leading: Icon(Icons.filter),
          //   ),
          // ),


          // Divider(color: Colors.black),
          // InkWell(
          //   onTap: () {
          //     print('pressed');
          //   },
          //   child: ListTile(
          //     title: Text('Setting'),
          //     leading: Icon(Icons.settings),
          //   ),
          // ),

          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutScreen()));
            },
            child: ListTile(
              title: Text('About Us'),
              leading: Icon(Icons.help),
            ),
          ),
          InkWell(
            onTap: () async{
              SharedPreferences prefs=await SharedPreferences.getInstance();
              // String token=await prefs.getString('token').toString();

             Scaffold.of(context).showSnackBar(SnackBar(content: Text('Logging Out Clearing Preferences')));
           prefs.clear();
  Timer(
    Duration(seconds: 1), () {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder:(context)=>LoginScreen()));
    }
    );     
           
            },
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.verified_user),
            ),
          ),
          

  //                InkWell(
  //           onTap: () async{
  //             // SharedPreferences prefs=await SharedPreferences.getInstance();
  //             // String token=await prefs.getString('token').toString();

  //            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Going to Login Without Clearing Preferences')));
  //         //  prefs.clear();
  // Timer(
  //   Duration(seconds: 1), () {
  // Navigator.of(context).pushReplacement(
  //   MaterialPageRoute(builder:(context)=>LoginScreen()));
  //   }
  //   );     
           
  //           },
  //           child: ListTile(
  //             title: Text('Go to Login'),
  //             leading: Icon(Icons.verified_user),
  //           ),
  //         ),


        ],
      ),
    );
  }
}
