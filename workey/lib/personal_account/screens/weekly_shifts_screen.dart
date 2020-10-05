import 'package:flutter/material.dart';

import '../../personal_account/widgets/time_table.dart';

class WeeklyShiftsScreen extends StatefulWidget {
  @override
  _WeeklyShiftsScreenState createState() => _WeeklyShiftsScreenState();
}

class _WeeklyShiftsScreenState extends State<WeeklyShiftsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Shifts'),
      ),
      body: TimeTable(),
    );
  }
}
