import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class AppOrganizationSelector extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        List<AppOrganization>? orgList = appProvider.organizationList;
        return Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            leading: AppBackIconButton(),
            title: TextField(
              controller: _searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Try "Charity Water"',
                border: InputBorder.none,
              ),
            ),
            centerTitle: false,
            bottom: AppBasic.appBarBorder(),
            actions: [
              IconButton(
                icon: Icon(LineIcons.times),
                onPressed: ()=> _searchController.clear(),
              ),
            ],
          ),
          body: orgList != null
              ? orgList.isNotEmpty
                  ? ListView.separated(
                      padding: kAppPadding,
                      itemCount: orgList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        AppOrganization organization = orgList[index];
                        return Container();
                      },
                    )
                  : Center(
                      child: Text('No Available Organization'),
                    )
              : Center(child: AppProgressIndicator()),
        );
      },
    );
  }
}
