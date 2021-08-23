import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Components/Table/table_components.dart';
import 'package:green_apple_pay/Utility/Classes/Table/table_class.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';

class TransactionHistoryPage extends StatefulWidget {

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  List<AppRowData> rowDataList = AppData.rowDataList;
  List<AppRowData> indexedRowDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: AppBackIconButton(),
        title: Text('Transaction History', style: kAppBarLightTextStyle),
        bottom: AppBasic.appBarBorder(),
        elevation: 0,
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 25),
        children: [
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: rowDataList.length,
            separatorBuilder: (context, index) => AppDivider(),
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
          AppDivider()
        ],
      ),
    );
  }
}
