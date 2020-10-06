import 'package:flutter/material.dart';
import 'package:timetable/timetable.dart';
import 'package:time_machine/time_machine.dart';

import '../../personal_account/widgets/time_table.dart';

enum ShiftTime {
  start,
  end,
}

class WeeklyShiftsScreen extends StatefulWidget {
  @override
  _WeeklyShiftsScreenState createState() => _WeeklyShiftsScreenState();
}

class _WeeklyShiftsScreenState extends State<WeeklyShiftsScreen> {
  List<BasicEvent> _list = [];
  TimeOfDay _timeOfDay_start;
  TimeOfDay _timeOfDay_end;

  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  void _addBasicEvent() {
    setState(() {
      _list.add(
        BasicEvent(
          id: DateTime.now(),
          title: 'Test',
          color: Colors.green,
          start: LocalDate.today().at(
            LocalTime(
              _timeOfDay_start.hour,
              _timeOfDay_start.minute,
              0,
            ),
          ),
          end: LocalDate.today().at(
            LocalTime(
              _timeOfDay_end.hour,
              _timeOfDay_end.minute,
              0,
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _timeOfDay_start = TimeOfDay.now();
    _timeOfDay_end = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    // _list = [
    // BasicEvent(
    //   id: 0,
    //   title: 'My Event',
    //   color: Colors.blue,
    //   start: LocalDate.today().at(LocalTime(13, 0, 0)),
    //   end: LocalDate.today().at(LocalTime(15, 0, 0)),
    // ),
    //   BasicEvent(
    //     id: 1,
    //     title: 'My Event',
    //     color: Colors.blue,
    //     start: LocalDate.today().at(LocalTime(9, 0, 0)),
    //     end: LocalDate.today().at(LocalTime(10, 0, 0)),
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Shifts'),
      ),
      body: TimeTable(_list),
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
                      TextField(
                        readOnly: true,
                        controller: _startTimeController,
                        onTap: () => _pickTime(setModalState, ShiftTime.start),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: 'Start',
                        ),
                      ),
                      TextField(
                        readOnly: true,
                        controller: _endTimeController,
                        onTap: () => _pickTime(setModalState, ShiftTime.end),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: 'End',
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      FlatButton(
                        onPressed: () {
                          _addBasicEvent();
                          Navigator.pop(context);
                        },
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Add shift',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   title: Text(
                      //     'Start: ${_timeOfDay.hour}:${_timeOfDay.minute}',
                      //   ),
                      //   trailing: Icon(Icons.timer),
                      //   onTap: () => _pickTime(setModalState),
                      // ),
                      // ListTile(
                      //   title: Text(
                      //     'End: ${_timeOfDay.hour}:${_timeOfDay.minute}',
                      //   ),
                      //   trailing: Icon(Icons.timer),
                      //   onTap: () => _pickTime(setModalState),
                      // ),
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

  _pickTime(Function setModalState, ShiftTime shiftTime) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _timeOfDay_start,
      builder: (context, child) {
        return Theme(
          data: ThemeData(),
          child: child,
        );
      },
    );
    if (time != null) {
      if (shiftTime == ShiftTime.start) {
        setModalState(() {
          _timeOfDay_start = time;
          _startTimeController.text =
              '${_timeOfDay_start.hour}:${_timeOfDay_start.minute}';
        });
      } else if (shiftTime == ShiftTime.end) {
        setModalState(() {
          _timeOfDay_end = time;
          _endTimeController.text =
              '${_timeOfDay_end.hour}:${_timeOfDay_end.minute}';
        });
      }
    }
  }
}
