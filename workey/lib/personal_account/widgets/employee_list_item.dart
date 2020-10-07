import 'package:flutter/material.dart';
import 'package:workey/general/models/group_employee_model.dart';

class EmployeeListItem extends StatelessWidget {
  final GroupEmployeeModel groupEmployeeModel;

  EmployeeListItem(this.groupEmployeeModel);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
