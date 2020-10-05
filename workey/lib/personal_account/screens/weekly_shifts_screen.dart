import 'package:flutter/material.dart';

import '../../personal_account/widgets/time_table.dart';

class WeeklyShiftsScreen extends StatefulWidget {
  @override
  _WeeklyShiftsScreenState createState() => _WeeklyShiftsScreenState();
}

class _WeeklyShiftsScreenState extends State<WeeklyShiftsScreen> {
  TimeOfDay _timeOfDay;

  @override
  void initState() {
    super.initState();
    _timeOfDay = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Shifts'),
      ),
      body: TimeTable(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      ListTile(
                        title: Text(
                          'Start: ${_timeOfDay.hour}:${_timeOfDay.minute}',
                        ),
                        trailing: Icon(Icons.timer),
                        onTap: () => _pickTime(setModalState),
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  _pickTime(Function setModalState) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
      builder: (context, child) {
        return Theme(
          data: ThemeData(),
          child: child,
        );
      },
    );
    if (time != null) {
      setModalState(() {
        _timeOfDay = time;
      });
    }
  }
}
