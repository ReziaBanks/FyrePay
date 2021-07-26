import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Functions/app_actions.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class DonationSettingsPage extends StatefulWidget {
  @override
  _DonationSettingsPageState createState() => _DonationSettingsPageState();
}

class _DonationSettingsPageState extends State<DonationSettingsPage> {
  // Handles the max donation text field
  TextEditingController _donationController = TextEditingController();
  // Sets up the values for the radio buttons (Round up & Monthly Add on)
  List<double?> _roundUpOptions = [null, 1, 2, 5, 10, 25];
  List<double?> _addOnOptions = [null, 10, 20, 30, 40, 50];
  bool _showSpinner = false;
  double? _monthlyAddOn;
  double? _roundUpAmount;
  TextStyle _style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: kGray4DColor,
  );

  @override
  void didChangeDependencies() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    updateContent(appProvider);
    super.didChangeDependencies();
  }

  void updateDonationSettings(AppProvider appProvider) async{
    /// Checks if user exist and stores it in the user variable
    User? user = FirebaseApi().getCurrentUser();
    // Stores the max donation user input value into maxDonationText
    String maxDonationText = _donationController.text;
    // Converts the maxDonationText into type Double
    double? maxDonation = double.tryParse(maxDonationText);

    // Error handling messages
    if(maxDonation == null && maxDonationText.isNotEmpty){
      Fluttertoast.showToast(msg: 'Max Monthly Donation is badly formatted');
      return;
    }

    if(user == null){
      Fluttertoast.showToast(msg: 'User does not exist');
      return;
    }

    setState(() {
      _showSpinner = true;
    });

    // Update the user's preferences with Firebase
    try {
      Map<String, dynamic> data = {
        'round_up_amount': _roundUpAmount,
        'monthly_add_on': _monthlyAddOn,
        'max_monthly_donation': maxDonation,
      };

      await FirebaseApi().updateUserDocument('${user.uid}', data);
      Fluttertoast.showToast(msg: 'Donation Settings Updated');
      AppActions.getUser(appProvider);
    }
    catch(e){
      Fluttertoast.showToast(msg: 'An Error Occurred');
      print(e);
    }
    setState(() {
      _showSpinner = false;
    });
  }

  void updateContent(AppProvider appProvider){
    AppUser? user = appProvider.appUser;
    if(user != null){
      _monthlyAddOn = user.settings.monthlyAddOn;
      _roundUpAmount = user.settings.roundUpAmount;
      double? maxMonthlyDonation = user.settings.maxMonthlyDonation;
      if(maxMonthlyDonation != null){
        _donationController.text = '$maxMonthlyDonation';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, children) {
        return ModalProgressHUD(
          inAsyncCall: _showSpinner,
          progressIndicator: AppProgressIndicator(),
          child: GestureDetector(
            onTap: () {
              AppFunctions.unFocusPage(context);
            },
            child: Scaffold(
              appBar: AppBar(
                leading: AppBackIconButton(),
                title: Text(
                  'Donation Settings',
                  style: kAppBarLightTextStyle,
                ),
                actions: [
                  IconButton(
                    icon: Icon(LineIcons.check),
                    onPressed: () {
                      updateDonationSettings(appProvider);
                    },
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
                      double? value = _roundUpOptions[index];
                      return AppRadioTile<double?>(
                        getTitle: (double? value) {
                          if (value != null) {
                            return '\$$value';
                          } else {
                            return 'Off';
                          }
                        },
                        onPressed: (double? value) {
                          setState(() {
                            _roundUpAmount = value;
                          });
                        },
                        value: value,
                        groupValue: _roundUpAmount,
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
                      double? value = _addOnOptions[index];
                      return AppRadioTile<double?>(
                        getTitle: (double? value) {
                          if (value != null) {
                            return '\$$value';
                          } else {
                            return 'Off';
                          }
                        },
                        onPressed: (double? value) {
                          setState(() {
                            _monthlyAddOn = value;
                          });
                        },
                        value: value,
                        groupValue: _monthlyAddOn,
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
          ),
        );
      }
    );
  }
}

class AppRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String Function(T) getTitle;
  final Function(T) onPressed;

  AppRadioTile({
    required this.getTitle,
    required this.value,
    required this.groupValue,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kLightPrimaryColor,
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
                getTitle(value),
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
