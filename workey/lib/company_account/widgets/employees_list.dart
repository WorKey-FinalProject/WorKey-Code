import 'package:flutter/material.dart';

class EmployeesList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<EmployeesList> {
  List<String> emp = [
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third'
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return FlatButton(
          child: Text(emp[index]),
          onPressed: null,
        );
      },
      itemCount: emp.length,
    );
  }
}