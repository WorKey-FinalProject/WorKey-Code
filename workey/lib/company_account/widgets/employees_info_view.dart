import 'package:flutter/material.dart';

class EmployeesInfoView extends StatelessWidget {
  final String name = 'Info';

  String get getName {
    return this.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Info'),
        ),
      ),
    );
  }
}
