import 'package:flutter/material.dart';

class EmployeesShiftsView extends StatelessWidget {
  final String name = 'Shifts';

  String get getName {
    return this.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              'Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Hours',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Salary',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(
                Text('data'),
              ),
              DataCell(
                Text('data'),
              ),
              DataCell(
                Text('data'),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text(
                  'data',
                ),
              ),
              DataCell(
                Text('data'),
              ),
              DataCell(
                Text('data'),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text('data'),
              ),
              DataCell(
                Text('data'),
              ),
              DataCell(
                Text('data'),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
