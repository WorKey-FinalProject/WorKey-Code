import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/icons_row_pages/settings_view.dart';
import '../widgets/group_screen_widgets/group_view.dart';
import '../widgets/icons_row_pages/sub_groups_list.dart';
import '../widgets/icons_row_pages/employees_list.dart';
import '../widgets/group_screen_widgets/icons_row.dart';

enum SelectedIcon {
  subGroups,
  employees,
  settings,
}

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  SelectedIcon selectedIcon = SelectedIcon.settings;

  void _selectedIconHandler(SelectedIcon newSelectedIcon) {
    setState(() {
      this.selectedIcon = newSelectedIcon;
    });
  }

  Widget _contantHandler() {
    switch (selectedIcon) {
      case SelectedIcon.settings:
        return SettingsView();
        break;
      case SelectedIcon.subGroups:
        return SubGroupsList();
        break;
      case SelectedIcon.employees:
        return EmployeesList();
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
          width: constraints.maxWidth,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: GroupView(),
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
