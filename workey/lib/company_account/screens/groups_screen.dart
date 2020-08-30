import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/employees_list.dart';
import '../widgets/icons_row.dart';

enum SelectedIcon {
  subGroups,
  employees,
  location,
  settings,
}

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  SelectedIcon selectedIcon = SelectedIcon.employees;

  void _selectedIconHandler(SelectedIcon newSelectedIcon) {
    setState(() {
      this.selectedIcon = newSelectedIcon;
    });
  }

  Widget _contantHandler() {
    switch (selectedIcon) {
      case SelectedIcon.subGroups:
        break;
      case SelectedIcon.employees:
        return EmployeesList();
        break;
      case SelectedIcon.location:
        break;
      case SelectedIcon.settings:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.25,
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    null;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'LOGO',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: constraints.maxHeight * 0.01,
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: constraints.maxHeight * 0.20,
                width: MediaQuery.of(context).size.width,
                child: IconsRow(_selectedIconHandler),
              ),
              Divider(
                thickness: constraints.maxHeight * 0.01,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  child: _contantHandler(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
