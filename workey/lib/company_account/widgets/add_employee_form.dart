import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/models/personal_account_model.dart';

import '../../general/widgets/profile_picture.dart';
import '../../general/models/snackbar_result.dart';
import '../../general/models/work_group_model.dart';
import '../../general/providers/company_groups.dart';

class AddEmployeeForm extends StatefulWidget {
  @override
  _AddEmployeeForm createState() => _AddEmployeeForm();
}

class _AddEmployeeForm extends State<AddEmployeeForm> {
  // final workGroupLocationController = GoogleMapController;
  List<PersonalAccountModel> personalAccountList = [];
  List<String> tempSearchList = [];
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
            tempSearchList.add(element.email);
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
        workGroupLogo: '',
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

  @override
  void dispose() {
    _employeeEmailController.dispose();
    _employeePositionController.dispose();
    _employeeSalaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

              _textFieldForm(_employeeEmailController, 'Employee\'s Email'),
              _textFieldForm(_employeeSalaryController, 'Employee\'s Salary'),
              _textFieldForm(
                  _employeePositionController, 'Employee\'s Position'),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 100,
              //         height: 100,
              //         margin: EdgeInsets.only(top: 8.0, right: 10.0),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //               width: 1, color: Theme.of(context).primaryColor),
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(30),
              //           ),
              //         ),
              //         child: _workGroupLogoController.text.isEmpty
              //             ? Align(
              //                 alignment: Alignment.center,
              //                 child: Text('Enter a URL'))
              //             : FittedBox(
              //                 child:
              //                     Image.network(_workGroupLogoController.text),
              //                 fit: BoxFit.cover,
              //               ),
              //       ),
              //       Expanded(
              //         child: TextFormField(
              //           controller: _workGroupLogoController,
              //           keyboardType: TextInputType.url,
              //           decoration: InputDecoration(labelText: 'Image URL'),
              //           onSaved: (value) {
              //             _workGroupLogoController.text = value;
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await _addNewWorkGroup();
                    },
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Done"),
                  ),
                ),
              )
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
