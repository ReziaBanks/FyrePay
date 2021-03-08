import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunctions {
  static void navigate(BuildContext context, Widget page){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> page));
  }

  static void unFocusPage(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void navigateAndRemove(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }
}