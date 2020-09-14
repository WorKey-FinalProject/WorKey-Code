import 'package:flutter/material.dart';

class EmployeesShiftsView extends StatelessWidget {
  final String name = 'Shifts';

  String get getName {
    return this.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Shifts'),
      ),
    );
  }
}
