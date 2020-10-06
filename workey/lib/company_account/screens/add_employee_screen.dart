import 'package:flutter/material.dart';

import '../widgets/add_employee_form.dart';

class AddEmployeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: AddEmployeeForm(),
    );
  }
}
