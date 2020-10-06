import 'package:flutter/material.dart';
import 'package:timetable/timetable.dart';
import 'package:time_machine/time_machine.dart';

class TimeTable extends StatefulWidget {
  final List<BasicEvent> list;

  TimeTable(this.list);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimetableController<BasicEvent> _controller;

  // List<BasicEvent> list = [
  //   BasicEvent(
  //     id: 0,
  //     title: 'My Event',
  //     color: Colors.blue,
  //     start: LocalDate.today().at(LocalTime(13, 0, 0)),
  //     end: LocalDate.today().at(LocalTime(15, 0, 0)),
  //   ),
  //   BasicEvent(
  //     id: 1,
  //     title: 'My Event',
  //     color: Colors.blue,
  //     start: LocalDate.today().at(LocalTime(9, 0, 0)),
  //     end: LocalDate.today().at(LocalTime(10, 0, 0)),
  //   ),
  // ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = TimetableController(
      eventProvider: EventProvider.list(widget.list),
      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(8, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.days(7),
      firstDayOfWeek: DayOfWeek.sunday,
    );

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
