import 'package:flutter/material.dart';
import 'package:workey/general/models/group_employee_model.dart';

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  List<GroupEmployeeModel> employeesList = [
    GroupEmployeeModel(
      id: DateTime.now().toString(),
      workGroupId: DateTime.now().toString(),
      role: 'role1',
      salary: 'salary',
    ),
    GroupEmployeeModel(
      id: DateTime.now().toString(),
      workGroupId: DateTime.now().toString(),
      role: 'role2',
      salary: 'salary',
    ),
    GroupEmployeeModel(
      id: DateTime.now().toString(),
      workGroupId: DateTime.now().toString(),
      role: 'role3',
      salary: 'salary',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Members'),
      ),
      body: ListView.builder(
        itemCount: employeesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: null,
            leading: CircleAvatar(
              backgroundColor: Colors.black,
            ),
            title: Text(employeesList[index].role),
            subtitle: Text(employeesList[index].id),
          );
        },
      ),
    );
  }
}
