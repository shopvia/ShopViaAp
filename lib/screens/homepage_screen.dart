import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopvia/Constants.dart';
import 'package:shopvia/components/roundButton.dart';
import 'package:shopvia/screens/DrawerContent_screen.dart';
import 'package:shopvia/screens/login_screen.dart';
import 'package:shopvia/screens/product_search_list.dart';
import 'package:webview_flutter/webview_flutter.dart';
Future getTrendingItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  final response = await http.get(
      API_URL + ':' + PORT + '/api/trending/',
      headers: {HttpHeaders.authorizationHeader: "Token " + token});
  
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return (json.decode(response.body));
  } else {
    throw Exception("Failed to fetch data from /api/trending");
  }
}

class HomePageScreen extends StatefulWidget {
  static String id = 'homepage_screen.dart';

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

isLoggedIn() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=prefs.getString('token');
  return token;
}

class _HomePageScreenState extends State<HomePageScreen> {
  Future trendingitems;
  // bool _autovalidate=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String query;
  @override
  void initState() {
isLoggedIn().then((result){
      if(result==null)
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    });

trendingitems=getTrendingItems();
    super.initState();
      }
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
                  autovalidateMode: AutovalidateMode.always,
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
                          prefix: Icon(Icons.search,color: Colors.black,),
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
                    // this.setState(() {_autovalidateMode=true;});
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
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Trending Items',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.blueAccent,decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double,)),
                  )
                ,
                Flexible(
              flex: 12,
              child: FutureBuilder(
                  future: trendingitems,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              color: Colors.teal,
                            );
                          },
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: Container(
                                  height: 800,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.center,
                                          child: Icon(Icons.image,
                                              color: Colors.grey, size: 50)),
                                      // Image.network(
                                      //   snapshot.data[index]
                                      //       ['imageLink'],
                                      //   fit: BoxFit.cover,
                                      //   colorBlendMode: BlendMode.screen,
                                      //   color: Colors.teal,
                                      //   width: 80.0,
                                      //   loadingBuilder:
                                      //       (context, child, progress) {
                                      //     return progress == null
                                      //         ? child
                                      //         : LinearProgressIndicator(
                                      //             backgroundColor: Colors.teal);
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                                title: Text(
                                  snapshot.data[index]['Name']
                                      .toString()
                                      .trim(),
                                  textAlign: TextAlign.justify,
                                ), // subtitle: snapshot.data['searchResults'][index]['Price']=="None"?Text('0'):Text(snapshot.data[index]['Price']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      snapshot.data[index]
                                              ['Price']
                                          .toString()
                                          .trim(),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.teal),
                                    ),
                                  ],
                                ),
                                trailing: FlatButton(
                                    color: Colors.teal,
                                    child: Text(
                                      'View',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => MaterialApp(
                                                    home: Scaffold(
                                                      appBar: AppBar(
                                                        title: ListTile(
                                                          title: Text(
                                                            'Product Detail',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                          leading: IconButton(
                                                            icon: Icon(Icons
                                                                .arrow_back),
                                                            color: Colors.white,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      body: WebView(
                                                        initialUrl: snapshot
                                                                    .data
                                                            [index]['Link'],
                                                      ),
                                                    ),
                                                  )));
                                    }));

                            // leading: Text(index.toString()),
                            // title: Text('No Name'),
                            // subtitle:Text('0'),
                            // trailing:FlatButton(onPressed: (){}, child:Text('Buy')));}
                          });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error in loading data'),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }))
                
                
                
                ],
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
