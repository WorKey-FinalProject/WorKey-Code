import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../general/models/group_employee_model.dart';
import '../../general/models/personal_account_model.dart';
import '../../general/widgets/profile_picture.dart';
import '../../general/models/snackbar_result.dart';
import '../../general/models/work_group_model.dart';
import '../../general/providers/company_groups.dart';

class AddEmployeeForm extends StatefulWidget {
  final CompanyGroups provider;

  AddEmployeeForm(this.provider);
  @override
  _AddEmployeeForm createState() => _AddEmployeeForm();
}

class _AddEmployeeForm extends State<AddEmployeeForm> {
  // final workGroupLocationController = GoogleMapController;
  List<PersonalAccountModel> personalAccountList = [];
  List<PersonalAccountModel> tempSearchList = [];
  final _employeeEmailController = TextEditingController();
  final _employeeSalaryController = TextEditingController();
  final _employeePositionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _searchNewEmployee(String searchValue) {
    if (searchValue.isEmpty) {
      setState(() {
        personalAccountList = [];
        tempSearchList = [];
      });
    } else {
      personalAccountList.forEach((element) {
        if (element.email.startsWith(searchValue)) {
          setState(() {
            tempSearchList.add(element);
          });
        }
      });
    }
  }

  Future<void> _addNewWorkGroup() async {
    final workGroupProvider =
        Provider.of<CompanyGroups>(context, listen: false);

    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();

//GroupEmployeeModel newEmoloyee = GroupEmployeeModel(id: null, workGroupId: null)
      WorkGroupModel newWorkGroup = WorkGroupModel(
        dateOfCreation: DateTime.now().toString(),
        workGroupName: _employeeEmailController.text,
        logo: '',
      );

      var isError = false;
      String message;
      try {
        await workGroupProvider.addToFirebaseAndList(newWorkGroup);
      } on PlatformException catch (err) {
        message = 'An error occurred';
        isError = true;

        if (err.message != null) {
          message = err.message;
        }
      } catch (err) {
        isError = true;
        print(err);
      }

      if (isError == false) {
        message = 'Changes saved successfully';
      }

      Navigator.pop(
        context,
        SnackBarResult(
          message: message,
          isError: isError,
        ),
      );
    }
  }

  Future<List<PersonalAccountModel>> _fetchPersonalList() async {
    personalAccountList = await widget.provider.getAllPersonalAccounts()
        as List<PersonalAccountModel>;
    return personalAccountList;
  }

  @override
  void dispose() {
    _employeeEmailController.dispose();
    _employeePositionController.dispose();
    _employeeSalaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _fetchPersonalList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (searchValue) => _searchNewEmployee(searchValue),
                  decoration: InputDecoration(
                    //prefixIcon: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black),iconSize: 20.0,onPressed: ,),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Search Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key('${tempSearchList[index]}'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(Icons.delete, color: Colors.white),
                              Text('Remove',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Confirmation"),
                              content: const Text(
                                  "Are you sure you want to remove this employee?"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("Delete")),
                                FlatButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: GestureDetector(
                        // onTap: () => Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EmployeeDetailScreen(),
                        //   ),
                        // ),
                        child: Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  tempSearchList[index].profilePicture),
                            ),
                            // ProfilePicture(
                            //   isEditable: false,
                            //   size: 30,
                            //   imageUrl: '', //employeesList[index].picture,
                            // ),

                            title: Text(
                              '${tempSearchList[index].firstName}',
                              style: Theme.of(context).textTheme.title,
                            ),
                            subtitle: Text(
                              '${tempSearchList[index].lastName}',
                            ),
                            trailing: MediaQuery.of(context).size.width > 460
                                ? FlatButton.icon(
                                    icon: Icon(Icons.person_outline_rounded),
                                    label: Text('Employee details'),
                                    onPressed:
                                        null, //() => deleteTx(emp[index].id),
                                    textColor: Theme.of(context).accentColor,
                                  )
                                : IconButton(
                                    icon: Icon(Icons.person_outline_rounded),
                                    color: Theme.of(context).accentColor,
                                    onPressed: () =>
                                        null //deleteTx(transactions[index].id),
                                    ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: tempSearchList.length,
                ),
              ),
              //           _textFieldForm(_employeeEmailController, 'Employee\'s Email'),
              //           _textFieldForm(_employeeSalaryController, 'Employee\'s Salary'),
              //           _textFieldForm(
              //               _employeePositionController, 'Employee\'s Position'),

              //           Flexible(
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: RaisedButton(
              //                 onPressed: () async {
              //                   FocusScope.of(context).requestFocus(new FocusNode());
              //                   await _addNewWorkGroup();
              //                 },
              //                 padding: EdgeInsets.symmetric(horizontal: 50),
              //                 elevation: 2,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                 ),
              //                 child: Text("Done"),
              //               ),
              //             ),
              //           )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldForm(TextEditingController controller, String labelText) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter an email address';
          }
          return null;
        },
        decoration: InputDecoration(labelText: labelText),
        onSaved: (value) {
          controller.text = value;
        },
      ),
    );
  }
}
