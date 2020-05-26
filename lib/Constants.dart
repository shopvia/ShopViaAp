import 'package:flutter/material.dart';

const kAppBarText = TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.w900,
  fontSize: 30,
);

const kDivider = 10;

const kSearchBarText1 =
    TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500);

const kSearchBarText2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

const kTextFieldDecoration = InputDecoration(
  hintText: ('Enter a value'),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  fillColor: Colors.red ,
  
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
