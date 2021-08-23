import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Organization/organization_page.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:share_plus/share_plus.dart';

class AppOrganizationManagementTile extends StatelessWidget {
  final AppManagedOrganization managedOrganization;
  final Function()? onPressed;
  final Function()? onRemove;

  AppOrganizationManagementTile({
    required this.managedOrganization,
    this.onPressed,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.2,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'REMOVE',
              color: Colors.red,
              icon: Icons.delete,
              onTap: onRemove,
            ),
          ],
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kDividerColor,
                  width: 0.75,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  managedOrganization.organization.name,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${managedOrganization.percent}%',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppMiniOrganizationCard extends StatelessWidget {
  final AppOrganizationDonation organizationDonation;

  AppMiniOrganizationCard({
    required this.organizationDonation,
  });

  @override
  Widget build(BuildContext context) {
    AppOrganization organization = organizationDonation.organization;
    return InkWell(
      onTap: () {
        AppFunctions.navigate(context, OrganizationPage(organization));
      },
      child: Row(
        children: [
          Container(
            width: 120,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage('${organization.imageURL}'),
              fit: BoxFit.cover,
            )),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12),
              color: kLightGrayECColor,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${organization.name}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Total Donations: \$${organizationDonation.totalDonation}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppOrganizationCard extends StatelessWidget {
  final AppOrganization organization;
  AppOrganizationCard(this.organization);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppFunctions.navigate(context, OrganizationPage(organization));
      },
      child: Column(
        children: [
          Container(
            height: 250,
            // width: 364,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                image: DecorationImage(
                  image: NetworkImage(organization.imageURL),
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kLightPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  organization.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: kGray4DColor,
                  ),
                ),
                Text(
                  'View',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrganizationCardV2 extends StatelessWidget {
  final AppOrganization organization;
  final Function()? onPressed;

  OrganizationCardV2(
    this.organization, {
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhiteColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onPressed != null
            ? onPressed
            : () =>
                AppFunctions.navigate(context, OrganizationPage(organization)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: kDividerColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    organization.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: kLetterSpacing,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share(
                          'Visit ${organization.website} to learn more about ${organization.name}');
                    },
                    child: Icon(
                      Ionicons.share_outline,
                      color: kGray4DColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              AppDivider(),
              SizedBox(height: 20),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: organization.imageURL,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      organization.about,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kGray4DColor,
                        height: 1.55,
                        fontSize: 14.5,
                        letterSpacing: kLetterSpacing,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              AppDivider(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Color(0xFF62BB46),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        '50%',
                        style: TextStyle(
                          letterSpacing: kLetterSpacing,
                          color: kWhiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Learn More',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: kLetterSpacing,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
