import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/employee_detail_screen.dart';

class EmployeesList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<EmployeesList> {
  List<String> emp = [
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third',
    // 'first',
    // 'second',
    // 'third'
  ];
  @override
  Widget build(BuildContext context) {
    var addEmployeeButton = Container(
      padding: EdgeInsets.only(
        bottom: 10,
        top: 20,
      ),
      alignment: emp.isEmpty ? Alignment.center : Alignment.bottomRight,
      child: RawMaterialButton(
        onPressed: () {},
        elevation: 2.0,
        fillColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
    );
    return emp.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'There are no employee\'s in this group yet',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'To add new employee click on the plus button',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              addEmployeeButton,
            ],
          )
        : Stack(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeDetailScreen(),
                      ),
                    ),
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('Profile Pic'),
                            ),
                          ),
                        ),
                        title: Text(
                          emp[index],
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(DateTime.now()),
                        ),
                        trailing: MediaQuery.of(context).size.width > 460
                            ? FlatButton.icon(
                                icon: Icon(Icons.person_outline_rounded),
                                label: Text('Employee details'),
                                onPressed:
                                    null, //() => deleteTx(emp[index].id),
                                textColor: Theme.of(context).accentColor,
                              )
                            : IconButton(
                                icon: Icon(Icons.person_outline_rounded),
                                color: Theme.of(context).accentColor,
                                onPressed: () =>
                                    null //deleteTx(transactions[index].id),
                                ),
                      ),
                    ),
                  );
                },
                itemCount: emp.length,
              ),
              addEmployeeButton,
            ],
          );
  }
}
