import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFunctions {
  static void navigate(BuildContext context, Widget page){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> page));
  }
}