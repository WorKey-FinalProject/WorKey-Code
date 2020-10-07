import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../general/models/group_employee_model.dart';
import '../../../general/providers/company_groups.dart';
import '../../../general/models/work_group_model.dart';
import '../../screens/employee_detail_screen.dart';
import '../add_employee_screen.dart';

class EmployeesList extends StatefulWidget {
  final CompanyGroups subWorkGroupsProvider;

  EmployeesList(this.subWorkGroupsProvider);

  @override
  _State createState() => _State();
}

class _State extends State<EmployeesList> {
  var _isLoading = false;
  WorkGroupModel currentWorkGroup;

  List<GroupEmployeeModel> employeesList = [];

  _getEmployeesList() {
    employeesList = widget.subWorkGroupsProvider.getEmployeeList;
  }

  // _deleteEmployee(index) {
  //   widget.subWorkGroupsProvider.deleteEmployeeById(
  //     employeesList[index].id,
  //     currentWorkGroup.id,
  //   );
  //   setState(() {
  //     _getEmployeesList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _getEmployeesList();

    var addEmployeeButton = Container(
      padding: EdgeInsets.only(
        bottom: 10,
        top: 20,
      ),
      alignment:
          employeesList.isEmpty ? Alignment.center : Alignment.bottomRight,
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddEmployeeScreen(widget.subWorkGroupsProvider),
            ),
          );
        },
        elevation: 2.0,
        fillColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
    );
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : employeesList.isEmpty &&
                widget.subWorkGroupsProvider.getCurrentWorkGroup == null
            ? Center(
                child: Text('Choose a work group to add employyes'),
              )
            : employeesList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'There are no employee\'s in this group yet',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'To add new employee click on the plus button',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      addEmployeeButton,
                    ],
                  )
                : Stack(
                    children: [
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeDetailScreen(
                                    employeesList[index].id),
                              ),
                            ),
                            child: Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      employeesList[index].picture.isEmpty
                                          ? AssetImage(
                                              'assets/images/no_image_available.png',
                                            )
                                          : NetworkImage(
                                              employeesList[index].picture,
                                            ),
                                ),
                                title: Text(
                                    '${employeesList[index].firstName} ${employeesList[index].lastName}'),
                                isThreeLine: true,
                                subtitle: Text(
                                  '${employeesList[index].email} \n${employeesList[index].role} \n${DateFormat.yMd().format(employeesList[index].entryDate)}',
                                ),
                                trailing: MediaQuery.of(context).size.width >
                                        460
                                    ? FlatButton.icon(
                                        icon:
                                            Icon(Icons.person_outline_rounded),
                                        label: Text('Employee details'),
                                        onPressed:
                                            null, //() => deleteTx(emp[index].id),
                                        textColor:
                                            Theme.of(context).accentColor,
                                      )
                                    : IconButton(
                                        icon:
                                            Icon(Icons.person_outline_rounded),
                                        color: Theme.of(context).accentColor,
                                        onPressed: () =>
                                            null //deleteTx(transactions[index].id),
                                        ),
                              ),
                            ),
                          );
                        },
                        itemCount: employeesList.length,
                      ),
                      widget.subWorkGroupsProvider.getCurrentWorkGroup != null
                          ? addEmployeeButton
                          : Container(),
                    ],
                  );
  }
}
