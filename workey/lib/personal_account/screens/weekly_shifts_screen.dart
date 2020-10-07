import 'package:flutter/material.dart';
import 'package:timetable/timetable.dart';
import 'package:time_machine/time_machine.dart';
import 'package:workey/general/models/group_employee_model.dart';

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

  List<GroupEmployeeModel> _dropdownItems = [
    GroupEmployeeModel(id: '1', workGroupId: '1', email: 'a'),
    GroupEmployeeModel(id: '2', workGroupId: '2', email: 'b'),
    GroupEmployeeModel(id: '3', workGroupId: '3', email: 'c'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
    GroupEmployeeModel(id: '4', workGroupId: '4', email: 'd'),
  ];

  List<DropdownMenuItem<GroupEmployeeModel>> _dropdownMenuItems;
  GroupEmployeeModel _selectedEmployee;

  List<DropdownMenuItem<GroupEmployeeModel>> buildDropDownMenuItems(
    List listItems,
  ) {
    List<DropdownMenuItem<GroupEmployeeModel>> items = List();
    for (GroupEmployeeModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.email),
          value: listItem,
        ),
      );
    }
    return items;
  }

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

  void deleteBasicEvent(BasicEvent basicEvent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to delete this Event?'),
        actions: [
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              setState(() {
                _list.remove(basicEvent);
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _timeOfDay_start = TimeOfDay.now();
    _timeOfDay_end = TimeOfDay.now();

    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedEmployee = _dropdownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Shifts'),
      ),
      body: TimeTable(_list, deleteBasicEvent),
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
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              readOnly: true,
                              controller: _startTimeController,
                              onTap: () =>
                                  _pickTime(setModalState, ShiftTime.start),
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.calendar_today),
                                labelText: 'Start',
                              ),
                            ),
                          ),
                          VerticalDivider(
                            width: 30,
                          ),
                          Flexible(
                            child: TextField(
                              readOnly: true,
                              controller: _endTimeController,
                              onTap: () =>
                                  _pickTime(setModalState, ShiftTime.end),
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.calendar_today),
                                labelText: 'End',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: DropdownButton<GroupEmployeeModel>(
                            value: _selectedEmployee,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedEmployee = value;
                              });
                            }),
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
