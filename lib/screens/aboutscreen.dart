import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('About Us',style: TextStyle(color:Colors.white),),
        ),
         body: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               
               UserAccountsDrawerHeader(
  
            accountName: Text('Asmita Neupane'),
            accountEmail: Text('neupaneashmita2056@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child:Image.network('https://astranix.com/wp-content/uploads/2020/03/asmita-photo.jpg')
                ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal[100],
            ),
          ),

ListTile(
  leading:Image.network('https://astranix.com/wp-content/uploads/2020/03/asmita-photo.jpg'),
  title: Text('Asmita Neupane'),
  subtitle: Text('neupane.ashmita2056@gmail.com'),
),

          SizedBox(
            height: 100,
            child: Hero(
        tag: 'Asmita',
        child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){

              },
              child: Image.network('https://astranix.com/wp-content/uploads/2020/03/asmita-photo.jpg',
                fit: BoxFit.contain,
              ),
            ),
        ),
            ),
          )


             ],
           ),
         )
      
    );
  }
}