import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Components/Organization/organization_component.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Functions/app_actions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ManageOrganizationPage extends StatefulWidget {
  @override
  _ManageOrganizationPageState createState() => _ManageOrganizationPageState();
}

class _ManageOrganizationPageState extends State<ManageOrganizationPage> {
  List<AppManagedOrganization> _activeManagedOrganizationList = [];
  List<AppManagedOrganization> _inActiveManagedOrganizationList = [];
  bool _showSpinner = false;

  @override
  void didChangeDependencies() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    updateContent(appProvider);
    super.didChangeDependencies();
  }

  void submitChanges(AppProvider appProvider) async{
    double activeTotal = getActivePercentTotal();
    bool factor = activeTotal == 100 || activeTotal == 0;
    User user = FirebaseApi().getCurrentUser();

    if(_activeManagedOrganizationList.isEmpty && _inActiveManagedOrganizationList.isEmpty){
      Toast.show('Add An Organization', context);
      return;
    }

    if(user == null){
      print('User in Empty');
      return;
    }
    if(!factor){
      Toast.show('Percentage Error', context);
      return;
    }
    setState(() {
      _showSpinner = true;
    });
    try{
      String userId = user.uid;
      List<AppManagedOrganization> managedOrganizationList = appProvider.managedOrganizationList;
      List<Map<String, dynamic>> dataList = [];

      for(AppManagedOrganization value in _activeManagedOrganizationList){
        dataList.add(value.toMap());
      }

      for(AppManagedOrganization value in _inActiveManagedOrganizationList){
        dataList.add(value.toMap());
      }

      await FirebaseApi().updateUserManagedOrganization(userId, managedOrganizationList, dataList);
      // Update AppProvider
      AppActions.getManagedOrganizations(appProvider);
      Toast.show('Update Successful', context);
    }
    catch(e){
      print(e);
    }
    setState(() {
      _showSpinner = false;
    });
  }

  void updateContent(AppProvider appProvider) {
    List<AppManagedOrganization> managedOrganizationList = appProvider.managedOrganizationList;
    List<AppManagedOrganization> activeList = [];
    List<AppManagedOrganization> inActiveList = [];

    for(AppManagedOrganization managedOrganization in managedOrganizationList){
      if(managedOrganization?.status == true){
        activeList.add(managedOrganization);
      }
      else{
        inActiveList.add(managedOrganization);
      }
    }
    setState(() {
      _activeManagedOrganizationList = [...activeList];
      _inActiveManagedOrganizationList = [...inActiveList];
    });
  }

  double getActivePercentTotal() {
    double total = 0;
    for (AppManagedOrganization managedOrganization
        in _activeManagedOrganizationList) {
      total = total + managedOrganization?.percent;
    }
    return total;
  }

  void showDialogBox(AppManagedOrganization managedOrganization) {
    TextEditingController percentController = TextEditingController();
    percentController.text = '${managedOrganization?.percent}';
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AppDialogBox(
          managedOrganization: managedOrganization,
          textEditingController: percentController,
          onPressed: (double value){
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
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      List<AppManagedOrganization> managedOrganizationList = appProvider.managedOrganizationList;
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
          body: managedOrganizationList.isNotEmpty
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
                    itemCount: _activeManagedOrganizationList.length,
                    itemBuilder: (context, index) {
                      AppManagedOrganization managedOrganization = _activeManagedOrganizationList[index];
                      return AppOrganizationManagementTile(
                        managedOrganization: managedOrganization,
                        onRemove: () {
                          setState(() {
                            _activeManagedOrganizationList
                                .remove(managedOrganization);
                          });
                        },
                        onStatusToggle: () {
                          setState(() {
                            _activeManagedOrganizationList
                                .remove(managedOrganization);
                            managedOrganization.updateStatus(!managedOrganization.status);
                            _inActiveManagedOrganizationList
                                .add(managedOrganization);
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
                    itemCount: _inActiveManagedOrganizationList.length,
                    itemBuilder: (context, index) {
                      AppManagedOrganization managedOrganization =
                          _inActiveManagedOrganizationList[index];
                      return AppOrganizationManagementTile(
                        managedOrganization: managedOrganization,
                        onPressed: () {
                          showDialogBox(managedOrganization);
                        },
                        onRemove: () {
                          setState(() {
                            _inActiveManagedOrganizationList
                                .remove(managedOrganization);
                          });
                        },
                        onStatusToggle: () {
                          setState(() {
                            _inActiveManagedOrganizationList
                                .remove(managedOrganization);
                            managedOrganization
                                .updateStatus(!managedOrganization.status);
                            _activeManagedOrganizationList
                                .add(managedOrganization);
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          )
              : Center(child: Text('No Added Organization')),
        ),
      );
    });
  }
}
