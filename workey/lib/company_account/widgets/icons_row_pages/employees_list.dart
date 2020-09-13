import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeesList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<EmployeesList> {
  List<String> emp = [
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third'
  ];
  @override
  Widget build(BuildContext context) {
    return emp.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => null,
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
                            icon: Icon(Icons.more),
                            label: Text('Employee details'),
                            onPressed: null, //() => deleteTx(emp[index].id),
                            textColor: Theme.of(context).accentColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.more),
                            color: Theme.of(context).accentColor,
                            onPressed: () =>
                                null //deleteTx(transactions[index].id),
                            ),
                  ),
                ),
              );
            },
            itemCount: emp.length,
          );
  }
}
