import 'package:flutter/material.dart';

class EmployeesInfoView extends StatefulWidget {
  final String name = 'Info';

  String get getName {
    return this.name;
  }

  @override
  _EmployeesInfoViewState createState() => _EmployeesInfoViewState();
}

class _EmployeesInfoViewState extends State<EmployeesInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Employees Name:'),
          ],
        ),
      ),
    );
  }
}
