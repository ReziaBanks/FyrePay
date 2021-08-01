import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Classes/Metric/metric_class.dart';
import 'package:green_apple_pay/Utility/Classes/Table/table_class.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';

/// Sample data to display throughout app for prototyping

class AppData {
  static String defaultUrl = 'https://www.greenapplepay.com/terms-of-use/';
  static String bankConnectionText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit vel in cursus volutpat.';
  static String passwordResetText =
      'Enter your email address below, we’ll send you a verification code.';

  static String organizationDescr1 = 'Wounded Warriors Canada is a national mental health service provider utilizing clinical best practices and evidence-based care to create an environment of compassion, resiliency and hope for Canada’s Veterans, First Responders and their families.';
  static String organizationAddress1 = '310 Byron Street South, Suite 4 Whitby, Ontario L1N 4P8';

  static String organizationImageUrl1 =
      'https://images.unsplash.com/photo-1615201427548-58316e349d8a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  static String organizationImageUrl2 =
      'https://images.unsplash.com/photo-1615146919563-70db4a72f100?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  static String organizationImageUrl3 =
      'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1490&q=80';

  static AppOrganization org1 = AppOrganization(
      uid: "iduasnkanmksanmksnma",
      name: 'The Children\'s Aid Society',
      email: 'test@hamiltoncas.com',
      about:
      'We continue to provide core child protection services, with a focus on keeping children and youth safe.',
      website: 'https://www.hamiltoncas.com/',
      address: '735 King Street East',
      imageURL: organizationImageUrl1,
  );

  static AppOrganization org2 = AppOrganization(
      uid: 'askansjasnjaknsjoa',
      name: 'Sick Kids Foundation',
      email: 'test@test.com',
      about:
      'We continue to provide core child protection services, with a focus on keeping children and youth safe.',
      website: 'https://www.SickKidsFoundation.com/',
      address: '222 King Street East',
      imageURL: organizationImageUrl2,
  );

  static List<AppOrganization> orgs = [org1, org2];
  //List of descriptions to be generated
  static List<String> descrList = [
    'Uber Eats',
    'Amazon',
    'Google Ads',
    'Uber',
    'Lyft',
    'Best Buy',
    'Playstation',
    'Fiverr',
    'Upwork'
  ];

  static String userInfoText = 'Manage your personal details - this information will be displayed to the Organizations that you decide to support.';

  static List<AppRowData> rowDataList = [
    AppRowData(
      columnDataList: [
        AppColumnData<DateTime>(
            id: 'asksmaklsm',
            title: 'Date',
            value: DateTime.now(),
            valueAsString: 'July 1st 2021',
        ),
        AppColumnData<double>(
            id: 'asksmaklsmsasasa',
            title: 'Amount', value: 20.00, valueAsString: '\$20.00'),
        AppColumnData(
            id: 'asksmaklsmasasasxzzxzxzx',
            title: 'Receipt',
            value: 'View',
            valueAsString: 'View',
            clickEvent: () {
              print('me');
            }),
      ],
      primaryColumnData: AppColumnData<DateTime>(
          id: 'asksmaklsm',
          title: 'Date', value: DateTime.now(), valueAsString: 'July 1st 2021'),
    ),
    AppRowData(
      columnDataList: [
        AppColumnData<DateTime>(
            id: 'asksmaklasac1sm',
            title: 'Date',
            value: DateTime.now(),
            valueAsString: 'June 1st 2021'),
        AppColumnData<double>(
            id: 'asksmakl11m',
            title: 'Amount', value: 24.50, valueAsString: '\$24.50'),
        AppColumnData(
            id: 'asksmakls12',
            title: 'Receipt',
            value: 'View',
            valueAsString: 'View',
            clickEvent: () {
              print('me');
            }),
      ],
      primaryColumnData: AppColumnData<DateTime>(
          id: 'asksmaklasac1sm',
          title: 'Date', value: DateTime.now(), valueAsString: 'June 1st 2021'),
    ),
  ];

  static String aboutUsS1 = 'Pencils of Promise, also known as PoP for short, is a non-profit organization that builds schools and increases educational opportunities in the developing world. Pencils of Promise was founded by Adam Braun in October 2008. It is a 501 organization with education programs in Laos, Guatemala and Ghana.';

  static List<AppMetric> metricList = [
    AppMetric(
      title: 'Total Donated',
      subtitle: 'Your total lifetime donations',
      cost: 100,
      color: Color(0xFF837ABF),
      iconData: Icons.account_balance_wallet,
    ),
    AppMetric(
      title: 'Last Month',
      subtitle: 'Total donated last month',
      cost: 25.19,
      color: Color(0xFF2D85D1),
      iconData: Icons.today,
    ),
    AppMetric(
      title: 'This Month',
      subtitle: 'Pending total for this month',
      cost: 7.83,
      color: Color(0xFFFE991E),
      iconData: Icons.star,
    ),
  ];
}
