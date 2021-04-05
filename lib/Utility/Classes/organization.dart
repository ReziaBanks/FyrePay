import 'package:flutter/material.dart';

class AppOrganization {
  final String uid;
  final String name;
  final String email;
  final String about;
  final String website;
  final String address;
  final String imageURL;

  AppOrganization({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.about,
    @required this.website,
    @required this.address,
    @required this.imageURL,
  });
}
