import 'package:flutter/material.dart';
import 'dart:async';
import 'components/roundButton.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';


Future<void> send(Email email) async {
   print("Send Called");
   print(email.body);
   print(email.subject);
   print(email.recipients);
   print(email.attachmentPaths);
   print(email.isHTML);
    

    String platformResponse;

    try {
      print("Before actual sending email");
      await FlutterEmailSender.send(email);
      print("After sending Email");
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
  }

class EmailSender extends StatefulWidget {
  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
     final Email email = Email(
      body: "Hello Body",
      subject: "Subject",
      recipients: ["sushilsubedi32@gmail.com"],
      attachmentPaths: [],
      isHTML: true,
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text('ShopVia')),
          backgroundColor: Colors.cyan,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RoundedButton(
                  title: "Send Email",
                  colour: Colors.lightBlueAccent,
                  onpress: () async{
                    // string sent=await send(email);
                    // print(sent);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}