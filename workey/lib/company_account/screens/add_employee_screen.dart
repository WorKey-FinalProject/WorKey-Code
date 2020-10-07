import 'package:flutter/material.dart';

import '../../general/providers/company_groups.dart';

import '../widgets/add_employee_form.dart';

class AddEmployeeScreen extends StatefulWidget {
  final CompanyGroups provider;

  AddEmployeeScreen(this.provider);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: AddEmployeeForm(widget.provider),
    );
  }
}
