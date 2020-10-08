import 'package:flutter/material.dart';
import 'package:workey/company_account/screens/add_employee_confirm_screen.dart';
import 'package:workey/general/models/group_employee_model.dart';

import '../../general/providers/company_groups.dart';

import '../widgets/add_employee_form.dart';

class AddEmployeeScreen extends StatefulWidget {
  final CompanyGroups provider;

  AddEmployeeScreen(this.provider);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  GroupEmployeeModel _selectedEmployee;

  void _selectedEmp(GroupEmployeeModel employeeModel) {
    setState(() {
      _selectedEmployee = employeeModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: _selectedEmployee == null
          ? AddEmployeeForm(widget.provider)
          : AddEmployeeConfirmScreen(provider, newEmployeeId),
    );
  }
}
