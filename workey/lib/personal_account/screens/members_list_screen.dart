import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/personal_account/widgets/employee_list_item.dart';

class MembersListScreen extends StatefulWidget {
  @override
  _MembersListScreenState createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  List<GroupEmployeeModel> employeeList; //= [
  //   GroupEmployeeModel(
  //     id: DateTime.now().toString(),
  //     workGroupId: DateTime.now().toString(),
  //     firstName: 'firstName',
  //     lastName: 'lastName',
  //     picture:
  //         'https://firebasestorage.googleapis.com/v0/b/workey-8c645.appspot.com/o/personal_account_pic%2F8X5JitmE2sTx7WJZGIPLosCCOxM2.jpg?alt=media&token=90883d65-8231-4f67-b910-657cd3215365',
  //     role: 'role1',
  //     salary: 'salary',
  //   ),
  //   GroupEmployeeModel(
  //     id: DateTime.now().toString(),
  //     workGroupId: DateTime.now().toString(),
  //     firstName: 'firstName',
  //     lastName: 'lastName',
  //     picture:
  //         'https://firebasestorage.googleapis.com/v0/b/workey-8c645.appspot.com/o/personal_account_pic%2F8X5JitmE2sTx7WJZGIPLosCCOxM2.jpg?alt=media&token=90883d65-8231-4f67-b910-657cd3215365',
  //     role: 'role2',
  //     salary: 'salary',
  //   ),
  //   GroupEmployeeModel(
  //     id: DateTime.now().toString(),
  //     workGroupId: DateTime.now().toString(),
  //     firstName: 'firstName',
  //     lastName: 'lastName',
  //     picture:
  //         'https://firebasestorage.googleapis.com/v0/b/workey-8c645.appspot.com/o/personal_account_pic%2F8X5JitmE2sTx7WJZGIPLosCCOxM2.jpg?alt=media&token=90883d65-8231-4f67-b910-657cd3215365',
  //     role: 'role3',
  //     salary: 'salary',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    final companyGroupsProvider =
        Provider.of<CompanyGroups>(context, listen: false);

    employeeList = companyGroupsProvider.getEmployeeList;
    print(employeeList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Members'),
      ),
      body: ListView.builder(
        itemCount: employeeList.length,
        itemBuilder: (context, index) {
          return EmployeeListItem(employeeList[index]);
          // return ListTile(
          //   onTap: null,
          //   leading: CircleAvatar(
          //     radius: 30,
          //     backgroundColor: Colors.black,
          //     backgroundImage: NetworkImage(
          //       employeeList[index].picture,
          //     ),
          //   ),
          //   title: Text(
          //       '${employeeList[index].firstName} ${employeeList[index].lastName}'),
          //   isThreeLine: true,
          //   subtitle: Text(
          //     '${employeeList[index].email} \n${employeeList[index].role}',
          //   ),
          // );
        },
      ),
    );
  }
}
