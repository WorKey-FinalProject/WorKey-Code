import 'package:flutter/material.dart';

import '../widgets/add_employee_confirm.dart';
import '../widgets/add_employee_search.dart';

import '../../general/models/group_employee_model.dart';
import '../../general/models/personal_account_model.dart';
import '../../general/providers/company_groups.dart';

class AddEmployeeScreen extends StatefulWidget {
  final CompanyGroups provider;

  AddEmployeeScreen(this.provider);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  GroupEmployeeModel _selectedEmployee;

  Future<void> _selectedEmp(PersonalAccountModel employeeModel) {
    setState(() {
      _selectedEmployee = GroupEmployeeModel(
          id: employeeModel.id,
          workGroupId: widget.provider.getCurrentWorkGroup.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: _selectedEmployee == null
          ? AddEmployeeSearch(widget.provider, _selectedEmp)
          : AddEmployeeConfirmScreen(widget.provider, _selectedEmployee.id),
    );
  }
}
