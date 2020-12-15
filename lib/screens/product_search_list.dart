import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopvia/Constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shopvia/screens/DrawerContent_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future getList(String query,String sorting) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  Response response;
  if (sorting==null)
  {
     response = await http.get(
      API_URL + ':' + PORT + '/api/products/?q=' + query,
      headers: {HttpHeaders.authorizationHeader: "Token " + token});
  }
  else
  {
     response = await http.get(
      API_URL + ':' + PORT + '/api/products/?q=' + query+'&&s='+sorting,
      headers: {HttpHeaders.authorizationHeader: "Token " + token});
  }
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
  String dropdownValue = 'Default';
  Future futureProducts;
  String query;
  _ProductListState(this.query);
  @override
  //this runs and initializes Product List by running getList (calling API)
  void initState() {
    super.initState();
    futureProducts = getList(this.query,null);

    // futureProducts = getList(this.query,null);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          actions: [
            Builder(
        builder: (BuildContext context) {
          return 
          // IconButton(
          //   icon: const Icon(Icons.message),
          //   onPressed: () {
          //     final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
          //     Scaffold.of(context).showSnackBar(snackBar);
          //   },
          // );
          DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;

                switch(dropdownValue)
                {
                  case "Name Ascending":
                  
                  print("Sorting By Name A-Z");
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Sorting By Name Alphabetically A-Z')));
                  setState(() {
                    futureProducts=getList(query,"nameasc");
                  });
                 Scaffold.of(context).showSnackBar(SnackBar(content: Text('Done Sorting.. Refreshing UI')));
                 break;
                  case "Name Descending":                  
                  print("Sorting By Name Z-A");
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Sorting By Name Alphabetically Z-A')));
                  setState(() {
                    futureProducts=getList(query,"namedesc");
                  
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Done Sorting.. Refreshing UI')));
                  break;
                  case "Price Ascending":
                  print("Sorting By Price Low to High");
                   Scaffold.of(context).showSnackBar(SnackBar(content: Text('Sorting By Price Low to High')));
                   setState(() {
                    futureProducts=getList(query,"priceasc");
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Done Sorting.. Refreshing UI')));
                 break;
                  case "Price Descending":
                  
                  print("Sorting By Price High to Low");
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Sorting By Price High to Low')));
                  setState(() {
                    futureProducts=getList(query,"pricedesc");
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Done Sorting.. Refreshing UI')));
                  
                  break;
                  default:
                  print("Default Sorting");
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Default Sorting')));
                  setState(() {
                    futureProducts=getList(query,null);
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Done Sorting.. Refreshing UI')));
                }
                });
              //  print(dropdownValue);
              //  print(query);

               },
              items: <String>[
                'Default',
                'Name Ascending',
                'Price Ascending',
                'Name Descending',
                'Price Descending'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
        },
      ),
            
            // DropdownButton<String>(
            //   value: dropdownValue,
            //   onChanged: (String newValue) {
            //     setState(() {
            //       dropdownValue = newValue;

            //     switch(dropdownValue)
            //     {
            //       case "Name Ascending":
                  
            //       print("Sorting By Name A-Z");
            //       setState(() {
            //         futureProducts=getList(query,"nameasc");
            //       });
            //      break;
            //       case "Name Descending":                  
            //       print("Sorting By Name Z-A");
            //       setState(() {
            //         futureProducts=getList(query,"namedesc");
            //       });
            //       break;
            //       case "Price Ascending":
            //       print("Sorting By Price Low to High");
            //       setState(() {
            //         futureProducts=getList(query,"priceasc");
            //       });
            //      break;
            //       case "Price Descending":
                  
            //       print("Sorting By Price High to Low");
            //       // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Sorting By Price High to Low')));
            //       setState(() {
            //         futureProducts=getList(query,"pricedesc");
            //       });
            //       break;
            //       default:
            //       print("Default Sorting");
                  
            //     }
            //     });
            //   //  print(dropdownValue);
            //   //  print(query);

            //    },
            //   items: <String>[
            //     'Default',
            //     'Name Ascending',
            //     'Price Ascending',
            //     'Name Descending',
            //     'Price Descending'
            //   ].map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            // ),




          ],
        ),
        drawer: Drawercontent(),
        body: Column(children: [
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
