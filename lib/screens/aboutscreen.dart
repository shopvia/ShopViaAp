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
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text("Team Lead",textAlign: TextAlign.start,style: TextStyle(fontSize:24,fontWeight:FontWeight.bold),),
                ListTile(

                  // leading:Image.network('https://astranix.com/wp-content/uploads/2020/03/asmita-photo.jpg'),
                  leading:Image.asset('lib/assets/asmita.jpg'),title: Text('Asmita Neupane'),
                  subtitle: Text('neupane.ashmita2056@gmail.com'),
                  trailing: Icon(Icons.person),
                ),
SizedBox(height: 20,),
                 Text("Developers",textAlign: TextAlign.start,style: TextStyle(fontSize:24,fontWeight:FontWeight.bold),),
                ListTile(

                  // leading:Image.network('https://astranix.com/wp-content/uploads/2020/03/asmita-photo.jpg'),
                  leading:Image.asset('lib/assets/santosh.jpg'),

                  title: Text('Santosh Chapagain'),
                  subtitle: Text('neupane.ashmita2056@gmail.com'),
                  trailing: Icon(Icons.person_outline),
                ),
                                ListTile(

                  // leading:Image.network('https://astranix.com/wp-content/uploads/2020/03/asmita-photo.jpg'),
                 leading:Image.asset('lib/assets/prashant.jpg'),
                  title: Text('Prashant Bagale'),
                  subtitle: Text('neupane.ashmita2056@gmail.com'),
                  trailing: Icon(Icons.person_outline),
                ),

        //   SizedBox(
        //       height: 100,
        //       child: Hero(
        // tag: 'Asmita',
        // child: Material(
        //       color: Colors.transparent,
        //       child: InkWell(
        //         onTap: (){

        //         },
        //         child: Image.network('https://astranix.com/wp-content/uploads/2020/03/asmita-photo.jpg',
        //           fit: BoxFit.contain,
        //         ),
        //       ),
        // ),
        //       ),
        //   )


               ],
             ),
           ),
         )
      
    );
  }
}