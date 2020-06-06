import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shopvia/screens/DrawerContent_screen.dart';

Future getProducts() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts');
  if (response.statusCode == 200) {
    return (json.decode(response.body));
  } else {
    throw Exception(
        "Failed to fetch data from http://192.168.1.3:8000/api/?q=laptops");
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DynamicApp());
  }
}

class DynamicApp extends StatefulWidget {
  @override
  _DynamicAppState createState() => _DynamicAppState();
}

class _DynamicAppState extends State<DynamicApp> {
 
  Future futureProducts;
  @override
  void initState() {
    super.initState();
    futureProducts = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Product List')),
        drawer: Drawercontent(),
        body: Column(children: [
          Flexible(
              flex: 1,
             
              child: Container()),
          Flexible(

              //we need our futurelist here
              flex: 12,
              child: FutureBuilder(
                  future: futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                            );
                          },
                          // itemCount: snapshot.data['searchList'].length,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                // leading: snapshot.data['searchList'][index]['imageLink']==null?Text('?'):Image.network(snapshot.data[index]['imageLink']),
                                // title: snapshot.data['searchList'][index]['Name']==null?Text('No Name'):Text(snapshot.data[index]['Name']),
                                // subtitle: snapshot.data['searchList'][index]['Price']==null?Text('0'):Text(snapshot.data[index]['Price']),
                                // trailing:FlatButton(onPressed: (){}, child:Text('Buy')));}
                                
                                
  //   "userId": 1,
  //   "id": 1,
  //   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  //   "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  // },

                                leading: Text(snapshot.data[index]['userId'].toString()),
                                title: Text(snapshot.data[index]['title']),
                                subtitle: Text(snapshot.data[index]['body']),
                                trailing:FlatButton(onPressed: (){}, child:Text('Buy')));}
                            
                            
                          );
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
