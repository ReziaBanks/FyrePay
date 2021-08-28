import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Classes/Table/table_class.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:line_icons/line_icons.dart';

class AppTableRow extends StatelessWidget {
  final AppRowData rowData;
  final bool isCollapsed;
  final Function()? onPressed;
  AppTableRow(
      this.rowData, {
        this.isCollapsed = true,
        this.onPressed,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingValue, vertical: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(rowData.primaryColumnData.title, style: TextStyle(
                  fontSize: 16,
                ),),
              ),
              Text(rowData.primaryColumnData.valueAsString, style: TextStyle(
                fontSize: 16,
                color: isCollapsed ? kPrimaryColor : kGray4DColor,
              ),),
              Spacer(flex: 2),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onPressed,
                child: Icon(
                  isCollapsed
                      ? LineIcons.chevronCircleDown
                      : LineIcons.chevronCircleUp,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: isCollapsed ? 0 : 25),
          !isCollapsed ? ListView.separated(
            itemCount: rowData.filteredList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index)=> SizedBox(height: 25),
            itemBuilder: (context, index){
              AppColumnData columnData = rowData.filteredList[index];
              return Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(columnData.title, style: TextStyle(
                      fontSize: 16,
                    ),),
                  ),
                  GestureDetector(
                    onTap: columnData.clickEvent,
                    child: Text(columnData.valueAsString, style: TextStyle(
                      fontSize: 16,
                      color: columnData.clickEvent != null ? kPrimaryColor : kGray4DColor,
                    ),),
                  ),
                  Spacer(flex: 2),
                ],
              );
            },
          ) : Container(),
        ],
      ),
    );
  }
}