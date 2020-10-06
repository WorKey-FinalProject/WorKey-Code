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
      date: DateTime.now(),
      //startTime: '14:00',
      //endTime: '22:00',
      //totalHours: '08:00',
      totalMoney: 240,
    ),
    ShiftModel(
      date: DateTime.now(),
      //startTime: '14:00',
      //endTime: '22:00',
      totalHours: '08:00',
      totalMoney: 240,
    ),
    ShiftModel(
      date: DateTime.now(),
      //startTime: '14:00',
      //endTime: '22:00',
      totalHours: '08:00',
      totalMoney: 240,
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
                      backgroundColor: getDayColor(shift.date.weekday),
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '${DateFormat.MEd().format(shift.date)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Stack(
                  //   alignment: Alignment.centerLeft,
                  //   children: [
                  //     Positioned(
                  //       child: Container(
                  //         width: 100,
                  //         height: 100,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.only(
                  //             bottomRight: Radius.circular(50),
                  //             topRight: Radius.circular(50),
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               offset: Offset(0, 5),
                  //               blurRadius: 50,
                  //               color: Color(0xFF12153D).withOpacity(0.2),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       child: Container(
                  //         margin: const EdgeInsets.all(3),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(6),
                  //           child: FittedBox(
                  //             child: Text(
                  //               '${DateFormat.MEd().format(shift.date)}',
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
                DataCell(
                  FittedBox(
                      //child: Text(shift.startTime),
                      ),
                ),
                DataCell(
                  FittedBox(
                      //child: Text(shift.endTime),
                      ),
                ),
                DataCell(
                  FittedBox(
                    child: Text(shift.totalHours),
                  ),
                ),
                DataCell(
                  FittedBox(
                    child: Text('${shift.totalMoney}'),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
