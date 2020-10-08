import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:workey/general/models/shift_model.dart';

class ShiftsScreen extends StatefulWidget {
  @override
  _ShiftsScreenState createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen> {
  List<ShiftModel> shiftsList = [
    ShiftModel(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      totalHours: null,
      totalWage: 240,
    ),
    ShiftModel(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      totalHours: null,
      totalWage: 240,
    ),
    ShiftModel(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      totalHours: null,
      totalWage: 240,
    ),
  ];

  Color getDayColor(int day) {
    switch (day) {

      /// Sunday
      case 7:
        return Colors.red;
        break;

      /// Monday
      case 1:
        return Colors.yellow;
        break;

      /// Tuesday
      case 2:
        return Colors.pink;
        break;

      /// Wednesday
      case 3:
        return Colors.green;
        break;

      /// Thursday
      case 4:
        return Colors.orange;
        break;

      /// Friday
      case 5:
        return Colors.lightBlue;
        break;

      /// Saturday
      case 6:
        return Colors.purple;
        break;

      default:
        return null;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: MediaQuery.of(context).size.width * 0.084,
            dataRowHeight: MediaQuery.of(context).size.height * 0.084,
            columns: [
              DataColumn(
                label: FittedBox(
                  child: Text('Date'),
                ),
              ),
              DataColumn(
                label: FittedBox(
                  child: Text('Start'),
                ),
              ),
              DataColumn(
                label: FittedBox(
                  child: Text('End'),
                ),
              ),
              DataColumn(
                label: FittedBox(
                  child: Text('Hours'),
                ),
              ),
              DataColumn(
                label: FittedBox(
                  child: Text('Wage'),
                ),
              ),
            ],
            rows: shiftsList.map<DataRow>((shift) {
              return DataRow(
                color: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  // All rows will have the same selected color.
                  if (states.contains(MaterialState.selected))
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.08);
                  // Even rows will have a grey color.
                  if (shiftsList.indexOf(shift) % 2 == 0)
                    return Colors.grey.withOpacity(0.3);
                  return null; // Use default value for other states and odd rows.
                }),
                cells: [
                  DataCell(
                    Container(
                      margin: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        backgroundColor: getDayColor(shift.startTime.weekday),
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '${DateFormat.MEd().format(shift.startTime)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      child: Text(
                          '${shift.startTime.hour}:${shift.startTime.minute}'),
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      child:
                          Text('${shift.endTime.hour}:${shift.endTime.minute}'),
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      child: Text('${shift.totalHours}'),
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      child: Text('${shift.totalWage}'),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
