import 'package:flutter/material.dart';
import 'package:shopvia/screens/homepage_screen.dart';

class Drawercontent extends StatefulWidget {
  @override
  _DrawercontentState createState() => _DrawercontentState();
}

class _DrawercontentState extends State<Drawercontent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //header
          UserAccountsDrawerHeader(
            accountName: Text('Your Account'),
            accountEmail: Text('santosh55@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          //body
          InkWell(
            onTap: () {
               Navigator.pushNamed(context, HomePageScreen.id);
            },
            child: ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
          ),
          InkWell(
            onTap: () {
              print('pressed');
            },
            child: ListTile(
              title: Text('My account'),
              leading: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {
              print('pressed');
            },
            child: ListTile(
              title: Text('My oder'),
              leading: Icon(Icons.shopping_basket),
            ),
          ),
          InkWell(
            onTap: () {
              print('pressed');
            },
            child: ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.dashboard),
            ),
          ),
          InkWell(
            onTap: () {
              print('pressed');
            },
            child: ListTile(
              title: Text('Filter Price'),
              leading: Icon(Icons.filter),
            ),
          ),
          Divider(color: Colors.black),
          InkWell(
            onTap: () {
              print('pressed');
            },
            child: ListTile(
              title: Text('Setting'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () {
              print('pressed');
            },
            child: ListTile(
              title: Text('About'),
              leading: Icon(Icons.help),
            ),
          ),
        ],
      ),
    );
  }
}
