import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/enum.dart';
import 'package:line_icons/line_icons.dart';


class AppBasic {
  static PreferredSizeWidget appBarBorder(){
    return PreferredSize(
      child: Container(
        color: Color(0xFFDFE5E8),
        height: 0.75,
      ),
      preferredSize: Size.fromHeight(0.75),
    );
  }
}


class AppTextField extends StatelessWidget {
  final String hintText;
  final FocusNode? node;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputAction textInputAction;
  final Function()? onEditingComplete;
  final TextInputType? keyboardType;

  AppTextField({
    required this.hintText,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.node,
    this.obscureText = false,
    this.keyboardType,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightPrimaryColor,
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
          hintText: hintText,
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

///This class is used to represent all text-buttons throughout the app
///A button must have text, however nothing else is required.
///This button is using AppButtonType.Light for its general theme
class AppButton extends StatelessWidget {
  final String title; //Body text of the button
  final Function? onPressed;
  final AppButtonType buttonType;
  final Color color; //Background-color

  AppButton({
    required this.title,
    this.onPressed,
    this.buttonType = AppButtonType.Bold,
    this.color = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonType == AppButtonType.Light ? kWhiteColor : color,
      child: InkWell(
        onTap: onPressed as void Function()?,
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
                color: buttonType == AppButtonType.Light ? color : kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///Represents a ListTile that has a leading widget and a trailing widget, which represents an
///forward chevron icon by default
///
/// This class requires a title, everything else is optional.
class AppContentTile extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color titleColor;
  final double height;
  final Widget trailingWidget;

  AppContentTile({
    required this.title,
    this.onPressed,
    this.titleColor = const Color(0xFF4D4D4D),
    this.height = 63,
    this.trailingWidget =
        const Icon(LineIcons.angleRight, size: 20, color: Color(0xFF4D4D4D)),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        color: kLightPrimaryColor,
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

/// Represents an animation that spins when something is loading
class AppProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator();
  }
}

/// Represents a text-button that is indicated on the AppBar
/// A title and onPressed event is required
class AppBarTextButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  AppBarTextButton({
    required this.title,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 25.0),
      child: Center(
        child: GestureDetector(
          onTap: onPressed as void Function()?,
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

/// Represents a component that has an icon followed by text.
///
/// The icon and text are required, everything else is optional.
class AppListTile extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color textColor;
  final double iconSize;

  AppListTile({
    required this.text,
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

/// A precise class that represents a dialog that pops up when the user modifies an organization percentage
class AppDialogBox extends StatelessWidget {
  final AppManagedOrganization managedOrganization;
  final TextEditingController textEditingController;
  final Function(double) onPressed;
  AppDialogBox({
    required this.managedOrganization,
    required this.textEditingController,
    required this.onPressed,
  });

  void onClicked(BuildContext context){
    String percentText = textEditingController.text;
    double? percent = double.tryParse(percentText);
    if(percent != null) {
      onPressed(percent);
      Navigator.pop(context);
    }
    else{
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Label representing the organization name
            Text(
              '${managedOrganization.organization.name}',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            // User enters a percentage amount for this organization
            Center(
              child: TextField(
                textAlign: TextAlign.center,
                controller: textEditingController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Percentage',
                ),
              ),
            ),
            SizedBox(height: 5),
            // Update button to apply percentage data
            Material(
              borderRadius: BorderRadius.circular(12.25),
              color: kPrimaryColor,
              child: InkWell(
                onTap: () {
                  onClicked(context);
                },
                child: Container(
                  height: 40,
                  width: 160,
                  child: Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBackIconButton extends StatelessWidget {
  final Color color;
  AppBackIconButton({this.color = kBlackColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.maybePop(context);
      },
      icon: Icon(
        LineIcons.angleLeft,
        size: 24,
        color: color,
      ),
    );
  }
}

class AppBoxCard extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  AppBoxCard({
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kLightPrimaryColor,
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFDFE5E8),
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(title, style: TextStyle(
              fontSize: 17,
              color: kGray4DColor,
            ),),
          ),
        ),
      ),
    );
  }
}

