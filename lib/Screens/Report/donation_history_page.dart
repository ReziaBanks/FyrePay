import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Components/Table/table_components.dart';
import 'package:green_apple_pay/Utility/Classes/Table/table_class.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';

class DonationHistoryPage extends StatefulWidget {
  @override
  _DonationHistoryPageState createState() => _DonationHistoryPageState();
}

class _DonationHistoryPageState extends State<DonationHistoryPage> {
  List<AppRowData> rowDataList = AppData.rowDataList;
  List<AppRowData> indexedRowDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: AppBackIconButton(),
        title: Text('Donation History', style: kAppBarLightTextStyle),
        elevation: 0,
        backgroundColor: Color(0xFFF8F9FA),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 25),
        children: [
          Divider(
            thickness: 1,
            color: Colors.black.withOpacity(0.075),
            height: 1,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: rowDataList.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.075),
              height: 1,
            ),
            itemBuilder: (context, index) {
              AppRowData rowData = rowDataList[index];
              return AppTableRow(
                rowData,
                isCollapsed: !indexedRowDataList.contains(rowData),
                onPressed: () {
                  setState(() {
                    if(indexedRowDataList.contains(rowData)){
                      indexedRowDataList.remove(rowData);
                    }
                    else{
                      indexedRowDataList.add(rowData);
                    }
                  });
                },
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.black.withOpacity(0.075),
            height: 1,
          ),
        ],
      ),
    );
  }
}