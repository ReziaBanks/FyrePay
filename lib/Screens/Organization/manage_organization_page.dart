import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Components/Organization/organization_component.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Functions/app_actions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ManageOrganizationPage extends StatefulWidget {
  @override
  _ManageOrganizationPageState createState() => _ManageOrganizationPageState();
}

class _ManageOrganizationPageState extends State<ManageOrganizationPage> {
  List<AppManagedOrganization> _managedOrgList = [];
  bool _showSpinner = false;

  @override
  void didChangeDependencies() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    updateContent(appProvider);
    super.didChangeDependencies();
  }

  void submitChanges(AppProvider appProvider) async {
    double activeTotal = getActivePercentTotal();
    bool factor = activeTotal == 100 || activeTotal == 0;
    User? user = FirebaseApi().getCurrentUser();

    if (_managedOrgList.isEmpty) {
      Fluttertoast.showToast(msg: 'Add An Organization');
      return;
    }

    if (user == null) {
      print('User in Empty');
      return;
    }
    if (!factor) {
      Fluttertoast.showToast(msg: 'Percentage Error');
      return;
    }
    setState(() {
      _showSpinner = true;
    });
    try {
      String userId = user.uid;
      List<AppManagedOrganization>? managedOrganizationList = appProvider.managedOrganizationList;
      List<Map<String, dynamic>> dataList = [];

      for (AppManagedOrganization value in _managedOrgList) {
        dataList.add(value.toMap());
      }

      if(managedOrganizationList != null) {
        await FirebaseApi().updateUserManagedOrganization(
            userId, managedOrganizationList, dataList);
        AppActions.getManagedOrganizations(appProvider);
        Fluttertoast.showToast(msg: 'Update Successful');
      }
      else{
        Fluttertoast.showToast(msg: 'An Error Occurred');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _showSpinner = false;
    });
  }

  void updateContent(AppProvider appProvider) {
    List<AppManagedOrganization>? managedOrganizationList =
        appProvider.managedOrganizationList;

    if(managedOrganizationList != null) {
      setState(() {
        _managedOrgList = [...managedOrganizationList];
      });
    }
  }

  double getActivePercentTotal() {
    double total = 0;
    List<AppManagedOrganization> activeManagedOrgList =  _managedOrgList.where((element) => element.status).toList();
    for (AppManagedOrganization managedOrganization in activeManagedOrgList) {
      total = total + managedOrganization.percent;
    }
    return total;
  }

  void showDialogBox(AppManagedOrganization managedOrganization) {
    TextEditingController percentController = TextEditingController();
    percentController.text = '${managedOrganization.percent}';
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AppDialogBox(
          managedOrganization: managedOrganization,
          textEditingController: percentController,
          onPressed: (double value) {
            setState(() {
              managedOrganization.updatePercentage(value);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        List<AppManagedOrganization> activeManagedOrgList = _managedOrgList.where((element) => element.status).toList();
        List<AppManagedOrganization> inActiveManagedOrgList = _managedOrgList.where((element) => !element.status).toList();
        return ModalProgressHUD(
          progressIndicator: AppProgressIndicator(),
          inAsyncCall: _showSpinner,
          child: Scaffold(
            backgroundColor: Color(0xFFF3F5F5),
            appBar: AppBar(
              title: Text(
                'Manage Organization',
                style: kAppBarLightTextStyle,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.check),
                  color: kPrimaryColor,
                  onPressed: () {
                    submitChanges(appProvider);
                  },
                ),
              ],
            ),
            body: _managedOrgList.isNotEmpty
                ? ListView(
                    padding: EdgeInsets.only(top: 25, bottom: 50),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ACTIVE',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: kGray4DColor,
                                  ),
                                ),
                                Text(
                                  '${getActivePercentTotal()}%',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: getActivePercentTotal() == 100
                                        ? Colors.blue
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: activeManagedOrgList.length,
                            itemBuilder: (context, index) {
                              AppManagedOrganization managedOrganization = activeManagedOrgList[index];
                              return AppOrganizationManagementTile(
                                managedOrganization: managedOrganization,
                                onRemove: () {
                                  setState(() {
                                    _managedOrgList.remove(managedOrganization);
                                  });
                                },
                                onStatusToggle: () {
                                  setState(() {
                                    managedOrganization.updateStatus(!managedOrganization.status);
                                  });
                                },
                                onPressed: () {
                                  showDialogBox(managedOrganization);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'INACTIVE',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: kGray4DColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: inActiveManagedOrgList.length,
                            itemBuilder: (context, index) {
                              AppManagedOrganization managedOrganization = inActiveManagedOrgList[index];
                              return AppOrganizationManagementTile(
                                managedOrganization: managedOrganization,
                                onPressed: () {
                                  showDialogBox(managedOrganization);
                                },
                                onRemove: () {
                                  setState(() {
                                    _managedOrgList.remove(managedOrganization);
                                  });
                                },
                                onStatusToggle: () {
                                  setState(() {
                                    managedOrganization.updateStatus(!managedOrganization.status);
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(child: Text('No Managed Organization')),
          ),
        );
      },
    );
  }
}
