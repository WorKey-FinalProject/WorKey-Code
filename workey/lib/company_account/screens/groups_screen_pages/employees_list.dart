import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../general/providers/company_groups.dart';
//import '../../widgets/test.dart';
import '../../../general/models/work_group_model.dart';
import '../../screens/employee_detail_screen.dart';

class EmployeesList extends StatefulWidget {
  String currentWorkGroupId;

  EmployeesList(this.currentWorkGroupId);

  @override
  _State createState() => _State();
}

class _State extends State<EmployeesList> {
  List<WorkGroupModel> subGroupsList = [];

  List<String> emp = [
    'first',
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
    final subWorkGroupsProvider = Provider.of<CompanyGroups>(context);
    subGroupsList = subWorkGroupsProvider.getWorkGroupsList;

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
                  return Dismissible(
                    key: Key('${emp[index]}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        ),
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Text('Remove',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Confirmation"),
                            content: const Text(
                                "Are you sure you want to remove this employee?"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Delete")),
                              FlatButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeDetailScreen(),
                        ),
                      ),
                      child: Card(
                        elevation: 5,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
