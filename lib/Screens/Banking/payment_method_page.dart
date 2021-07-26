import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackIconButton(),
        title: Text(
          'Payment Method',
          style: kAppBarLightTextStyle,
        ),
      ),
      body: Center(
        child: Text(
          'Working On Feature',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
