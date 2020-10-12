import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timetable/timetable.dart';
import 'package:time_machine/time_machine.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/widgets/auth/signup_type.dart';
import 'package:workey/general/widgets/date_picker.dart';
import 'package:workey/personal_account/widgets/employee_list_item.dart';

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
  AccountTypeChosen _accountTypeChosen;

  List<BasicEvent> _list = [];
  TimeOfDay _timeOfDay_start;
  TimeOfDay _timeOfDay_end;

  DateTime _dateTimeStart;
  DateTime _dateTimeEnd;

  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  Function _setModalState;

  List<GroupEmployeeModel> _dropdownItems = [];

  List<DropdownMenuItem<GroupEmployeeModel>> _dropdownMenuItems = [];
  GroupEmployeeModel _selectedEmployee;

  List<DropdownMenuItem<GroupEmployeeModel>> buildDropDownMenuItems(
    List listItems,
  ) {
    List<DropdownMenuItem<GroupEmployeeModel>> items = List();
    for (GroupEmployeeModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: EmployeeListItem(
            groupEmployeeModel: listItem,
            isDropDownItem: true,
          ),
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
          title: '${_selectedEmployee.firstName} ${_selectedEmployee.lastName}',
          color: Colors.blue,
          start: LocalDate.dateTime(_dateTimeStart).at(
            LocalTime(
              _timeOfDay_start.hour,
              _timeOfDay_start.minute,
              0,
            ),
          ),
          end: LocalDate.dateTime(_dateTimeEnd).at(
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

  void changeShifts() {
    print('changeShifts function for employee account');
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

  void fillDropDownList() {
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedEmployee =
        _dropdownItems.isEmpty ? null : _dropdownMenuItems[0].value;
  }

  void _selectedDateStart(DateTime dateTime) {
    _setModalState(() {
      _dateTimeStart = dateTime;
    });
  }

  void _selectedDateEnd(DateTime dateTime) {
    _setModalState(() {
      _dateTimeEnd = dateTime;
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
    final _auth = Provider.of<Auth>(context);
    final companyGroupsProvider =
        Provider.of<CompanyGroups>(context, listen: false);

    _accountTypeChosen = _auth.getAccountTypeChosen;
    _dropdownItems = companyGroupsProvider.getEmployeeList;

    fillDropDownList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Shifts'),
      ),
      body: TimeTable(
        _list,
        _accountTypeChosen == AccountTypeChosen.company
            ? deleteBasicEvent
            : changeShifts,
      ),
      floatingActionButton: _accountTypeChosen == AccountTypeChosen.personal
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setModalState) {
                        _setModalState = setModalState;
                        return ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: DatePicker(
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                    labelText: 'Date',
                                    selectedDate: _selectedDateStart,
                                  ),
                                ),
                                VerticalDivider(
                                  width: 30,
                                ),
                                Flexible(
                                  child: TextField(
                                    enabled:
                                        _dateTimeStart == null ? false : true,
                                    readOnly: true,
                                    controller: _startTimeController,
                                    onTap: () => _pickTime(ShiftTime.start),
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.timer),
                                      labelText: 'Start',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: DatePicker(
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                    labelText: 'Date',
                                    selectedDate: _selectedDateEnd,
                                  ),
                                ),
                                VerticalDivider(
                                  width: 30,
                                ),
                                Flexible(
                                  child: TextField(
                                    enabled:
                                        _startTimeController.text.isEmpty ||
                                                _dateTimeEnd == null
                                            ? false
                                            : true,
                                    readOnly: true,
                                    controller: _endTimeController,
                                    onTap: () => _pickTime(ShiftTime.end),
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.timer),
                                      labelText: 'End',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(20.0),
                              child: DropdownButton<GroupEmployeeModel>(
                                  isExpanded: true,
                                  value: _selectedEmployee,
                                  items: _dropdownMenuItems,
                                  onChanged: (value) {
                                    setModalState(() {
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

  _pickTime(ShiftTime shiftTime) async {
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
        _setModalState(() {
          _timeOfDay_start = time;
          _startTimeController.text = _timeOfDay_start.format(context);
        });
      } else if (shiftTime == ShiftTime.end) {
        _setModalState(() {
          _timeOfDay_end = time;
          _endTimeController.text = _timeOfDay_end.format(context);
        });
      }
    }
  }
}
