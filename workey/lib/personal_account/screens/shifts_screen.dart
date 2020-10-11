import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:workey/general/models/shift_model.dart';
import 'package:workey/general/providers/shifts.dart';

class ShiftsScreen extends StatefulWidget {
  final String name = 'Shifts';

  String get getName {
    return this.name;
  }

  @override
  _ShiftsScreenState createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen> {
  List<ShiftModel> shiftsList = [];

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
    final companyGroupsProvider = Provider.of<Shifts>(context, listen: false);

    shiftsList = companyGroupsProvider.getShiftList;

    shiftsList.forEach((element) {
      print(element.toJson());
    });

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
                      child: Text('${DateFormat.Hm().format(shift.startTime)}'),
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      child: Text('${DateFormat.Hm().format(shift.endTime)}'),
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      child: Text('${shift.totalHours.toStringAsFixed(2)}'),
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      child: Text('${shift.totalWage.toStringAsFixed(2)}'),
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
