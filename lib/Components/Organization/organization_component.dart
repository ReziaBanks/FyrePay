import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class AppOrganizationManagementTile extends StatelessWidget {
  final AppManagedOrganization managedOrganization;
  final Function() onPressed;
  final Function() onRemove;
  final Function() onStatusToggle;

  AppOrganizationManagementTile({
    @required this.managedOrganization,
    @required this.onPressed,
    @required this.onRemove,
    @required this.onStatusToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhiteColor,
      child: InkWell(
        onTap: onPressed,
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.2,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: managedOrganization?.status == true ? 'OFF' : 'ON',
              color: Colors.black45,
              icon: managedOrganization?.status == true ? Icons.toggle_off : Icons.toggle_on,
              onTap: onStatusToggle,
            ),
            IconSlideAction(
                caption: 'REMOVE',
                color: Colors.red,
                icon: Icons.delete,
                onTap: onRemove,
              ),
          ],
          child: Container(
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Color(0xFFC6C6C8),
                    ))),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${managedOrganization?.organization?.name}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${managedOrganization?.percent}%',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}