import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shopvia/screens/DrawerContent_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Future getProducts() async {
//   final response = await http.get('https://jsonplaceholder.typicode.com/posts');
//   if (response.statusCode == 200) {
//     return (json.decode(response.body));
//   } else {
//     throw Exception(
//         "Failed to fetch data from http://192.168.1.3:8000/api/?q=laptops");
//   }
// }
Future getList() async {
  final response = await http.get('http://192.168.254.5:8000/api/products/?q=laptops');
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return (json.decode(response.body));
  } else {
    throw Exception(
        "Failed to fetch data from http://192.168.254.7:8000/api/products/?q=laptops");
  }
}
class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
// final webView = FlutterWebviewPlugin();
  Future futureProducts;
  @override
  void initState() {
    super.initState();
    // webView.close();
    futureProducts = getList();
  }

  @override
  void dispose() {
    // webView.dispose();
//    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Product List')),
        drawer: Drawercontent(),
        body: Column(
        
          children: [
            SizedBox(height:10),
          Flexible(
           
           flex: 12,
              child: FutureBuilder(
                  future: futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              color: Colors.teal,
                              // indent: 110,
                              // endIndent: 120,
                            );
                          },
                          itemCount: snapshot.data["searchResults"].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                
                                 leading:
                                  Container(
                                    height:800,
                                    width:80,
                                    decoration: BoxDecoration(
                                      
                                      // borderRadius: BorderRadius.circular(20),
                                    color:Colors.white,
                                    
                                    ),
                                    child:
                                   Stack(
                                     children: <Widget>[
                                       Align(alignment: Alignment.center, child: Icon(Icons.image,color: Colors.grey,size:50)),
                                       Image.network(  
                                            snapshot.data['searchResults'][index]['imageLink'],
                                            fit: BoxFit.cover,
                                            
                                            colorBlendMode: BlendMode.screen,
                                            color: Colors.teal,
                                            width:80.0,
                                            loadingBuilder: (context,child,progress)
                                            {
                                              return progress==null?child:LinearProgressIndicator(backgroundColor:Colors.teal );
                                              },
                                              ),
                                     ],
                                   ),
                                    
                                  ),
                                
                                title: Text(snapshot.data['searchResults'][index]['Name'].toString().trim(),textAlign: TextAlign.justify,),                                // subtitle: snapshot.data['searchResults'][index]['Price']=="None"?Text('0'):Text(snapshot.data[index]['Price']),
                                subtitle: 
                                
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height:10),
                                    
                            //         Divider(
                            //   thickness: 1,
                            //   color: Colors.teal,
                            // ),
                                    Text(snapshot.data['searchResults'][index]['Price'].toString().trim(),
                                        style: TextStyle( fontSize:20,color:Colors.teal),),
                                  ],
                                ),
                                
                                trailing:FlatButton(
                                  color: Colors.teal,
                                  child:Text('View',textAlign: TextAlign.center,style: TextStyle(fontSize:16,color:Colors.white),),
                                  onPressed: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:(context)=>MaterialApp(
                                        home: Scaffold(
                                          appBar: AppBar(
                                            title:
                                            ListTile(
                                              title:Text('Product Detail',style: TextStyle(color:Colors.white,fontSize:20),),
                                              trailing: IconButton(icon:Icon(Icons.arrow_back),color:Colors.white, onPressed: () { 
                                                  Navigator.of(context).pop();
                                               },),
                                            ),
                                            ),
                                            body:WebView(
                                              initialUrl: snapshot.data['searchResults'][index]['Link'],
                                            ),
                                        ),
                                      )
                                      ));

                                                                       
                                      // Navigator.of(context).pushNamed("/webview");
                                    // print(snapshot.data['searchResults'][index]['Link'].toString());
                                  }
                                )
                                );


                                // leading: Text(index.toString()),
                                // title: Text('No Name'),
                                // subtitle:Text('0'),
                                // trailing:FlatButton(onPressed: (){}, child:Text('Buy')));}

                                // leading: Text(snapshot.data[index]['userId'].toString()),
                                // title: Text(snapshot.data[index]['title']),
                                // subtitle: Text(snapshot.data[index]['body']),
                                // trailing:FlatButton(onPressed: (){}, child:Text('Buy')));  
                          }
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
