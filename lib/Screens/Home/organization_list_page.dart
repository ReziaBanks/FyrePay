import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_document_to_class.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:provider/provider.dart';

class OrganizationListPage extends StatefulWidget {
  @override
  _OrganizationListPageState createState() => _OrganizationListPageState();
}

class _OrganizationListPageState extends State<OrganizationListPage> {

  void didChangeDependencies() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    getOrganizations(appProvider);
    super.didChangeDependencies();
  }
  
  void getOrganizations(AppProvider appProvider) async{
    List<AppOrganization> organizationList = [];
    List<DocumentSnapshot> organizationDocSnapshot = await FirebaseApi().getDocumentsByIDFilteredByStatus(kOrganizationId);

    for(DocumentSnapshot snapshot in organizationDocSnapshot){
      try {
        AppOrganization organization = FirebaseDocumentToClass().getOrganization(snapshot);
        if(organization != null) {
          organizationList.add(organization);
        }
      }
      catch(e){
        print(e);
      }
    }
    appProvider.updateOrganizationList(organizationList);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        List<AppOrganization> organizationList = appProvider.organizationList;
        return Scaffold(
          appBar: AppBar(
            title: Text('Organizations', style: kAppBarHeavyTextStyle,),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          body: organizationList != null
              ? ListView.separated(
            padding: kAppPadding,
            itemCount: organizationList.length,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemBuilder: (context, index) {
              AppOrganization organization = organizationList[index];
              return AppOrganizationCard(organization: organization);
            },
          )
              : Center(child: AppProgressIndicator(),),
        );
      }
    );
  }
}


