import 'package:flutter/material.dart';
import 'package:shopvia/screens/product_search_list.dart';
// import 'package:shopvia/screens/productlist_screen.dart';
// import 'package:shopvia/screens/welcome_screen.dart';

void main() => runApp(ShopVia());

class ShopVia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFDBDFF4),
        scaffoldBackgroundColor: Color(0xFFDBDFF4),
      ),
      home: DynamicApp(),
      // home: ProductList(),
    );
  }
}
