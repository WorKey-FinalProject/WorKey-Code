import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/icons_row_pages/settings_view.dart';
import '../widgets/icons_row_pages/location_view.dart';
import '../widgets/group_view.dart';
import '../widgets/icons_row_pages/sub_groups_list.dart';
import '../widgets/icons_row_pages/employees_list.dart';
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
        return SubGroupsList();
        break;
      case SelectedIcon.employees:
        return EmployeesList();
        break;
      case SelectedIcon.location:
        return LocationView();
        break;
      case SelectedIcon.settings:
        return SettingsView();
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
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width,
                  child: GroupsView(),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width,
                  child: IconsRow(_selectedIconHandler),
                ),
              ),
              Flexible(
                flex: 5,
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
