import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../general/models/group_employee_model.dart';
//import '../../general/models/personal_account_model.dart';
import '../../general/providers/auth.dart';
import '../../general/providers/company_groups.dart';
import '../../general/models/snackbar_result.dart';

class AddEmployeeConfirmScreen extends StatefulWidget {
  final CompanyGroups provider;
  final String newEmployeeId;

  AddEmployeeConfirmScreen(this.provider, this.newEmployeeId);

  @override
  _AddEmployeeConfirmScreenState createState() =>
      _AddEmployeeConfirmScreenState();
}

class _AddEmployeeConfirmScreenState extends State<AddEmployeeConfirmScreen> {
  final _formKey = GlobalKey<FormState>();

  final _employeeSalaryController = TextEditingController();
  final _employeePositionController = TextEditingController();

  Future<void> _addNewEmployee() async {
    final _newEmployeeProvider =
        Provider.of<CompanyGroups>(context, listen: false);
    final _auth = Provider.of<Auth>(context, listen: false);

    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();

      GroupEmployeeModel editedEmployee = GroupEmployeeModel(
        id: widget.newEmployeeId,
        salary: _employeeSalaryController.text,
        role: _employeePositionController.text,
        workGroupId: widget.provider.getCurrentWorkGroup.id,
      );

      var isError = false;
      String message;
      try {
        await _newEmployeeProvider.addToFirebaseAndList(editedEmployee);
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
    _employeePositionController.dispose();
    _employeeSalaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _textFieldForm(_employeeSalaryController, 'Employee\'s Salary'),
              _textFieldForm(
                  _employeePositionController, 'Employee\'s Position'),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await _addNewEmployee();
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
