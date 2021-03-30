import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:green_apple_pay/Screens/Organization/organization_page.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:green_apple_pay/Utility/Misc/enum.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final FocusNode node;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputAction textInputAction;
  final Function onEditingComplete;
  final TextInputType keyboardType;

  AppTextField({
    @required this.hintText,
    @required this.controller,
    @required this.textInputAction,
    this.node,
    this.obscureText = false,
    this.keyboardType,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightGrayECColor,
      height: 55,
      padding: EdgeInsets.only(left: 15),
      child: TextField(
        style: TextStyle(
          color: kGray4DColor,
          fontSize: 16,
        ),
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        cursorColor: Color(0xFF19A495),
        obscureText: obscureText,
        focusNode: node,
        onEditingComplete: onEditingComplete,
        controller: controller,
        decoration: InputDecoration(
          hintText: '$hintText',
          hintStyle: TextStyle(
            color: kGray85Color,
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final AppButtonType buttonType;
  final Color color;

  AppButton({
    @required this.title,
    this.onPressed,
    this.buttonType = AppButtonType.Bold,
    this.color = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonType == AppButtonType.Light
          ? kWhiteColor
          : color,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: buttonType == AppButtonType.Light
                ? Border.all(
              color: color,
              width: 1.5,
            )
                : null,
          ),
          height: 55,
          width: double.infinity,
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: 17,
                color: buttonType == AppButtonType.Light
                    ? color
                    : kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppContentTile extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color titleColor;
  final double height;
  final Widget trailingWidget;

  AppContentTile({
    @required this.title,
    this.onPressed,
    this.titleColor = const Color(0xFF4D4D4D),
    this.height = 63,
    this.trailingWidget =
    const Icon(Ionicons.chevron_forward, color: Color(0xFF4D4D4D)),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        color: kLightGrayECColor,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title',
              style: TextStyle(
                color: titleColor,
                fontSize: 16,
              ),
            ),
            trailingWidget,
          ],
        ),
      ),
    );
  }
}

class AppProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      // color: Colors.grey,
      // size: 40.0,
    );
  }
}

class AppCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  AppCheckBox({
    @required this.value,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Icon(
        value ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square,
        color: value ? kPrimaryColor : kGray85Color,
        size: 22,
      ),
    );
  }
}

class AppBarTextButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  AppBarTextButton({
    @required this.title,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 25.0),
      child: Center(
        child: GestureDetector(
          onTap: onPressed,
          child: Text(
            '$title',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
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
    @required this.organizationDonation,
  });

  @override
  Widget build(BuildContext context) {
    AppOrganization organization = organizationDonation?.organization;
    return InkWell(
      onTap: (){
        AppFunctions.navigate(context, OrganizationPage(organization: organization));
      },
      child: Row(
        children: [
          Container(
            width: 120,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${organization?.imageURL}'),
                  fit: BoxFit.cover,
                )
            ),
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
                  Text('${organization?.name}', style: TextStyle(
                    fontSize: 17,
                  ),),
                  SizedBox(height: 5),
                  Text('Total Donations: \$${organizationDonation?.totalDonation}', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),),
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
  AppOrganizationCard({@required this.organization});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        AppFunctions.navigate(context, OrganizationPage(organization: organization));
      },
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
                image: NetworkImage('${organization.imageURL}'),
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
              Text('${organization?.name}', style: TextStyle(
                fontSize: 16,
                color: kGray4DColor,
              ),),
              Text('View', style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),)
            ],
          ),
        ),
      ],),
    );
  }
}

class AppListTile extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color textColor;
  final double iconSize;

  AppListTile({
    @required this.text,
    this.iconData = Feather.check,
    this.textColor = kBlackColor,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: kPrimaryColor, size: iconSize),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            '$text',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              height: 150 / 100,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}