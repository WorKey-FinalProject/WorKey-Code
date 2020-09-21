import 'package:flutter/material.dart';
import 'package:workey/company_account/screens/employee_detail_screen.dart';
import 'package:workey/company_account/widgets/employee_sliver.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: EmployeeSliver(),
          ),
          bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 6.0,
              tabs: [
                Tab(
                  child: Text('1'),
                ),
                Tab(
                  child: Text('2'),
                ),
              ]),
        ),
      ),
    );
  }
}

Widget MyAppBarTabs() {
  return Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: IconButton(icon: Icon(Icons.ac_unit), onPressed: null),
        ),
        Container(
          child: Text(
            'data',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          child: IconButton(
              icon: Icon(
                Icons.access_alarm,
                color: Colors.blueGrey,
              ),
              onPressed: null),
        )
      ],
    ),
  );
}
