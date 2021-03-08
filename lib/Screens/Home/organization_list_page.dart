import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';

class OrganizationListPage extends StatefulWidget {
  @override
  _OrganizationListPageState createState() => _OrganizationListPageState();
}

class _OrganizationListPageState extends State<OrganizationListPage> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.separated(
        padding: kAppPadding,
        itemCount: 5,
        separatorBuilder: (context, index)=> SizedBox(height: 15),
        itemBuilder: (context, index){
          return AppOrganizationCard();
        },
      ),
    );
  }
}

class AppOrganizationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(children: [
        Container(
          height: 250,
          // width: 364,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              image: DecorationImage(
                image: NetworkImage('${AppData.organizationImageUrl1}'),
                fit: BoxFit.cover,
              )
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: kLightGrayECColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Wounded Warriors'),
              Text('View')
            ],
          ),
        ),
      ],),
    );
  }
}

