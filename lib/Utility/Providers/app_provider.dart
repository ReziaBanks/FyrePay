import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';

class AppProvider extends ChangeNotifier{
  List<AppOrganization> organizationList;

  void updateOrganizationList(List<AppOrganization> value){
    organizationList = value;
    notifyListeners();
  }

}