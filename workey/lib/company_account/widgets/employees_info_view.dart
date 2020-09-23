import 'package:flutter/material.dart';

class EmployeesInfoView extends StatefulWidget {
  String name = 'Info';

  String get getName {
    return this.name;
  }

  @override
  _EmployeesInfoViewState createState() => _EmployeesInfoViewState();
}

class _EmployeesInfoViewState extends State<EmployeesInfoView> {
  //TODO:get employees data.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Name: '),
          ],
        ),
      ),
    );
  }
}
