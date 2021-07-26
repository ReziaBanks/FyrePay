import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:line_icons/line_icons.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController screenNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  void openDialogBox(){
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text(AppData.userInfoText, style: TextStyle(
          fontFamily: kInter,
          fontWeight: FontWeight.normal
        ),),
        actions: [
          CupertinoDialogAction(
              child: Text('Close', style: TextStyle(
                color: kNotRedColor,
                fontFamily: kInter
              ),),
              onPressed: () => Navigator.pop(context)
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackIconButton(),
        title: Text('My Profile', style: kAppBarLightTextStyle,),
        actions: [
          IconButton(
            icon: Icon(LineIcons.infoCircle),
            onPressed: (){
              openDialogBox();
            },
          )
        ],
      ),
      body: ListView(
        padding: kAppPadding,
        children: [
          AppTextField(
            hintText: 'Enter Screen Name',
            controller: screenNameController,
          ),
          SizedBox(height: 15),
          AppTextField(
            hintText: 'Enter First Name',
            controller: firstNameController,
          ),
          SizedBox(height: 15),
          AppTextField(
            hintText: 'Enter Last Name',
            controller: lastNameController,
          ),
          SizedBox(height: 15),
          AppButton(title: 'Update Now')
        ],
      ),
    );
  }
}
