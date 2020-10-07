import 'package:flutter/material.dart';
import 'package:workey/general/models/group_employee_model.dart';

class EmployeeListItem extends StatelessWidget {
  final GroupEmployeeModel groupEmployeeModel;
  final bool isDropDownItem;

  EmployeeListItem({
    this.groupEmployeeModel,
    this.isDropDownItem,
  });

  @override
  Widget build(BuildContext context) {
    return isDropDownItem
        ? Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black,
                  backgroundImage: groupEmployeeModel.picture.isEmpty
                      ? AssetImage(
                          'assets/images/no_image_available.png',
                        )
                      : NetworkImage(
                          groupEmployeeModel.picture,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${groupEmployeeModel.firstName} ${groupEmployeeModel.lastName}',
                  ),
                ),
              ],
            ),
          )
        : ListTile(
            onTap: null,
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              backgroundImage: groupEmployeeModel.picture.isEmpty
                  ? AssetImage(
                      'assets/images/no_image_available.png',
                    )
                  : NetworkImage(
                      groupEmployeeModel.picture,
                    ),
            ),
            title: Text(
                '${groupEmployeeModel.firstName} ${groupEmployeeModel.lastName}'),
            isThreeLine: true,
            subtitle: Text(
              '${groupEmployeeModel.email} \n${groupEmployeeModel.role}',
            ),
          );
  }
}
