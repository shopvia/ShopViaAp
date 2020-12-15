import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopvia/Constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shopvia/screens/DrawerContent_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

//function to call api
Future getList(String query) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();

  final response = await http.get(
      API_URL + ':' + PORT + '/api/products/?q=' + query,
      headers: {HttpHeaders.authorizationHeader: "Token " + token});
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return (json.decode(response.body));
  } else {
    throw Exception("Failed to fetch data from /api/products/?q=itemname");
  }
}

class ProductList extends StatefulWidget {
  final String query;
  ProductList(this.query);
  @override
  _ProductListState createState() => _ProductListState(this.query);
}

class _ProductListState extends State<ProductList> {
  Future futureProducts;
  String query;
  _ProductListState(this.query);
  @override
  //this runs and initializes Product List by running getList (calling API)
  void initState() {
    super.initState();
    futureProducts = getList(this.query);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Product List')),
        drawer: Drawercontent(),
        body: Column(children: [
          SizedBox(height: 10),
          Flexible(
              flex: 12,
              child: FutureBuilder(
                  //we get futureProducts from initState()

                  future: futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              color: Colors.teal,
                            );
                          },
                          itemCount: snapshot.data["searchResults"].length,
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
                                      Image.network(
                                        snapshot.data['searchResults'][index]
                                            ['imageLink'],
                                        fit: BoxFit.cover,
                                        colorBlendMode: BlendMode.screen,
                                        color: Colors.teal,
                                        width: 80.0,
                                        loadingBuilder:
                                            (context, child, progress) {
                                          return progress == null
                                              ? child
                                              : LinearProgressIndicator(
                                                  backgroundColor: Colors.teal);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                //snapshot has data
                                //to access the data at eaccch index we use [index]
                                // we have Link, ImageLink, Name and Price keys to access data

                                title: Text(
                                  snapshot.data['searchResults'][index]['Name']
                                      .toString()
                                      .trim(),
                                  textAlign: TextAlign.justify,
                                ), // subtitle: snapshot.data['searchResults'][index]['Price']=="None"?Text('0'):Text(snapshot.data[index]['Price']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      snapshot.data['searchResults'][index]
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
                                                                    .data[
                                                                'searchResults']
                                                            [index]['Link'],
                                                        javascriptMode:
                                                            JavascriptMode
                                                                .unrestricted,
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
        ]));
  }
}
