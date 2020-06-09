import 'package:flutter/material.dart';
import 'package:shopvia/Constants.dart';
import 'package:shopvia/components/roundButton.dart';
import 'package:shopvia/screens/DrawerContent_screen.dart';
import 'package:shopvia/screens/product_search_list.dart';

class HomePageScreen extends StatefulWidget {
  static String id = 'homepage_screen.dart';

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool _autovalidate=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('ShopVia'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Form(
                  autovalidate: _autovalidate,
                  key:_formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        textAlign: TextAlign.center,
                        validator: (value){
                    if(value.length==0)
                      return 'Enter Item to Search';
                    else  
                      return null;
                  },
                  onSaved: (String val) {
                      this.setState(() {query=val;});
                  },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Search for product',
                          prefix: Icon(Icons.search),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                        child:
                        
                        Builder(builder:(context)=> RoundedButton(
                          title: 'Search',
                          onpress: () {

                            if(_formKey.currentState.validate())
                    { 
                      _formKey.currentState.save();
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Searching for: '+query)));
       Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ProductList(query)));
                      }
                    else{
                    this.setState(() {_autovalidate=true;});
                    }
        
                          },
                          colour: Colors.blueAccent,
                        ),
                      ),
                      )
                    ],
                  ),
                ),
              ),
              height: 190,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: <Widget>[Text('Trending Items')],
              ),
              height: 1000,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        ),
      ),
      drawer: Drawercontent(),
    );
  }
}
