import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/enum.dart';

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

  AppButton({
    @required this.title,
    @required this.onPressed,
    this.buttonType = AppButtonType.Bold,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: buttonType == AppButtonType.Light
              ? Colors.grey
              : kPrimaryColor,
          border: buttonType == AppButtonType.Light
              ? Border.all(
            color: kPrimaryColor,
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
                  ? kPrimaryColor
                  : kWhiteColor,
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