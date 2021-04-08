import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future getCategories() async {
  final response =
      await http.get(Uri.parse("http://127.0.0.1:8000/api/?q=laptops"));

  if (response.statusCode == 200) {
    return (json.decode(response.body));
  } else {
    throw Exception(
        "Failed to fetch data from http://127.0.0.1:8000/api/?q=laptops");
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.5,
        backgroundColor: Colors.cyan,
        title: Text('ShopVia'),
        centerTitle: true,
      ),
      body: Container(
          child: GridView.count(
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height),
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[])),
    );
  }
}
