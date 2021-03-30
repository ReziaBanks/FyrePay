import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class DonationSettingsPage extends StatefulWidget {
  @override
  _DonationSettingsPageState createState() => _DonationSettingsPageState();
}

class _DonationSettingsPageState extends State<DonationSettingsPage> {
  TextEditingController _donationController = TextEditingController();
  List<int> _roundUpOptions = [null, 1, 2, 5, 10, 25];
  List<int> _addOnOptions = [null, 10, 20, 30, 40, 50];
  int _addOnValue;
  int _roundUpValue = 1;
  TextStyle _style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: kGray4DColor,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFunctions.unFocusPage(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Donation Settings',
            style: kAppBarLightTextStyle,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {},
              color: kPrimaryColor,
            ),
          ],
        ),
        body: ListView(
          padding: kAppPadding,
          children: [
            Text('Round Up', style: _style),
            SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _roundUpOptions.length,
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemBuilder: (context, index) {
                int value = _roundUpOptions[index];
                return AppRadioTile<int>(
                  getTitle: (int value) {
                    if (value != null) {
                      return '\$$value';
                    } else {
                      return 'Off';
                    }
                  },
                  onPressed: (int value){
                    setState(() {
                      _roundUpValue = value;
                    });
                  },
                  value: value,
                  groupValue: _roundUpValue,
                );
              },
            ),
            SizedBox(height: 30),
            Text('Monthly Add On', style: _style),
            SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _addOnOptions.length,
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemBuilder: (context, index) {
                int value = _addOnOptions[index];
                return AppRadioTile<int>(
                  getTitle: (int value) {
                    if (value != null) {
                      return '\$$value';
                    } else {
                      return 'Off';
                    }
                  },
                  onPressed: (int value){
                    setState(() {
                      _addOnValue = value;
                    });
                  },
                  value: value,
                  groupValue: _addOnValue,
                );
              },
            ),
            SizedBox(height: 30),
            Text('Max Monthly Donation', style: _style),
            SizedBox(height: 20),
            AppTextField(
              hintText: 'Enter Max Monthly Donation',
              controller: _donationController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ),
    );
  }
}

class AppRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String Function(T) getTitle;
  final Function(T) onPressed;

  AppRadioTile({
    @required this.getTitle,
    @required this.value,
    @required this.groupValue,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kLightGrayECColor,
      child: InkWell(
        onTap: (){
          onPressed(value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${getTitle(value)}',
                style: TextStyle(
                  fontSize: 16,
                  color: kGray4DColor,
                ),
              ),
              Icon(
                value == groupValue ? Icons.radio_button_checked : Icons.radio_button_off,
                size: 20,
                color: value == groupValue ? kPrimaryColor : kGray76Color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
