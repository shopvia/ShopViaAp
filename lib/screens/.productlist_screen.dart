import 'package:flutter/material.dart';
import 'package:shopvia/components/roundButton.dart';
class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
          childAspectRatio:MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height),
  primary: false,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 2,
  children: <Widget>[
    Container(
      height:200,
      padding: const EdgeInsets.all(8),
      
      color: Colors.teal[100],
      child: Column(
        children:[
          Image.asset('lib/assets/macbook.jpg'),
          Text('Laptop',style:TextStyle(fontSize:24)),
          Text('Laptop is so good anyoneasdl asl;dk sladk saas;dlk can buy'),
          RoundedButton(
              onpress: () {
              },
              title: 'Buy Now',
              colour: Colors.lightBlueAccent,
            ),  
        ]
      )
    ),

    Container(
      height:200,
      padding: const EdgeInsets.all(8),
      
      color: Colors.teal[100],
      child: Column(
        children:[
          Image.asset('lib/assets/macbook.jpg'),
          Text('Laptop',style:TextStyle(fontSize:24)),
          Text('Laptop is so good anyoneasdl asl;dk sladk saas;dlk can buy'),
          RoundedButton(
              onpress: () {
              },
              title: 'Buy Now',
              colour: Colors.lightBlueAccent,
            ),
        ]
      )
    ),

    Container(
      height:200,
      padding: const EdgeInsets.all(8),
      
      color: Colors.teal[100],
      child: Column(
        children:[
          Image.asset('lib/assets/macbook.jpg'),
          Text('Laptop',style:TextStyle(fontSize:24)),
          Text('Laptop is so good anyoneasdl asl;dk sladk saas;dlk can buy'),
          RoundedButton(
              onpress: () {
              },
              title: 'Buy Now',
              colour: Colors.lightBlueAccent,
            ),
          
        ]
      )
    ),

    Container(
      height:200,
      padding: const EdgeInsets.all(8),
      
      color: Colors.teal[100],
      child: Column(
        children:[
          Image.asset('lib/assets/macbook.jpg'),
          Text('Laptop',style:TextStyle(fontSize:24)),
          Text('Laptop is so good anyoneasdl asl;dk sladk saas;dlk can buy'),
          RoundedButton(
              onpress: () {
              },
              title: 'Buy Now',
              colour: Colors.lightBlueAccent,
            ),
          
        ]
      )
    ),

    Container(
      height:200,
      padding: const EdgeInsets.all(8),
      
      color: Colors.teal[100],
      child: Column(
        children:[
          Image.asset('lib/assets/macbook.jpg'),
          Text('Laptop',style:TextStyle(fontSize:24)),
          Text('Laptop is so good anyoneasdl asl;dk sladk saas;dlk can buy'),
          RoundedButton(
              onpress: () {
              },
              title: 'Buy Now',
              colour: Colors.lightBlueAccent,
            ),
          
        ]
      )
    ),

    Container(
      height:200,
      padding: const EdgeInsets.all(8),
      
      color: Colors.teal[100],
      child: Column(
        children:[
          Image.asset('lib/assets/macbook.jpg'),
          Text('Laptop',style:TextStyle(fontSize:24)),
          Text('Laptop is so good anyoneasdl asl;dk sladk saas;dlk can buy'),
          RoundedButton(
              onpress: () {
              },
              title: 'Buy Now',
              colour: Colors.lightBlueAccent,
            ),
          
        ]
      )
    ),
   
  ],
)
      ),
    );
  }
}