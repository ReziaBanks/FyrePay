import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:green_apple_pay/Utility/Misc/extension.dart';

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

  static String dateToString(DateTime dateTime){
    DateFormat format = DateFormat.yMMMMEEEEd();
    String dateString = format.format(dateTime);
    return dateString;
  }

  static Map<String, dynamic> generateRandomDonation(String orgId, String userId){
    double cost = Random().nextDouble() * 192.18;
    double roundUp = Random().nextDouble() * 3.41;
    return {
      'cost': cost.toPrecision(2),
      'date_created': FieldValue.serverTimestamp(),
      'description': (AppData.descrList..shuffle()).first,
      'organization_id': orgId,
      'round_up': roundUp.toPrecision(2),
      'user_id': userId,
    };
  }
}