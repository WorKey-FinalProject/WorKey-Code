import 'package:flutter/material.dart';
import 'package:timetable/timetable.dart';
import 'package:time_machine/time_machine.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimetableController<BasicEvent> _controller;

  @override
  void initState() {
    super.initState();

    _controller = TimetableController(
      // A basic EventProvider containing a single event:
      eventProvider: EventProvider.list([
        // BasicEvent(
        //   id: 0,
        //   title: 'My Event',
        //   color: Colors.blue,
        //   start: LocalDate.today().at(LocalTime(13, 0, 0)),
        //   end: LocalDate.today().at(LocalTime(15, 0, 0)),
        // ),
        // BasicEvent(
        //   id: 1,
        //   title: 'My Event',
        //   color: Colors.blue,
        //   start: LocalDate.today().at(LocalTime(9, 0, 0)),
        //   end: LocalDate.today().at(LocalTime(10, 0, 0)),
        // ),
      ]),
      // Other (optional) parameters:

      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(8, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.days(7),
      firstDayOfWeek: DayOfWeek.sunday,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Timetable<BasicEvent>(
      controller: _controller,
      onEventBackgroundTap: (start, isAllDay) {
        _showSnackBar('Background tapped $start is all day event $isAllDay');
      },
      eventBuilder: (event) {
        return BasicEventWidget(
          event,
          onTap: () => _showSnackBar('Part-day event $event tapped'),
        );
      },
      allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
        event,
        info: info,
        onTap: () => _showSnackBar('All-day event $event tapped'),
      ),
    );
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}
