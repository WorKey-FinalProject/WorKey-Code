import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../screens/groups_screen.dart';

class IconsRow extends StatefulWidget {
  final Function selectedIconHandler;

  IconsRow(this.selectedIconHandler);

  @override
  _IconsRowState createState() => _IconsRowState();
}

class _IconsRowState extends State<IconsRow> {
  SelectedIcon selectedIcon = SelectedIcon.employees;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: FlatButton(
              onPressed: () {
                selectedIcon = SelectedIcon.employees;
                widget.selectedIconHandler(selectedIcon);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Icon(
                      Icons.people,
                      color: selectedIcon == SelectedIcon.employees
                          ? Theme.of(context).accentColor
                          : Colors.black,
                      // size: 35,
                    ),
                  ),
                  FittedBox(
                    child: const Text(
                      'Employees',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: FlatButton(
              onPressed: () {
                selectedIcon = SelectedIcon.location;
                widget.selectedIconHandler(selectedIcon);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Icon(
                      Icons.place,
                      color: selectedIcon == SelectedIcon.location
                          ? Theme.of(context).accentColor
                          : Colors.black,
                      // size: 35,
                    ),
                  ),
                  FittedBox(child: const Text('Location')),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: FlatButton(
              onPressed: () {
                selectedIcon = SelectedIcon.subGroups;
                widget.selectedIconHandler(selectedIcon);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Icon(
                      MdiIcons.graph,
                      color: selectedIcon == SelectedIcon.subGroups
                          ? Theme.of(context).accentColor
                          : Colors.black,
                      // size: 35,
                    ),
                  ),
                  FittedBox(child: const Text('Sub Groups')),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: FlatButton(
              onPressed: () {
                selectedIcon = SelectedIcon.settings;
                widget.selectedIconHandler(selectedIcon);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Icon(
                      Icons.settings,
                      color: selectedIcon == SelectedIcon.settings
                          ? Theme.of(context).accentColor
                          : Colors.black,
                      // size: 35,
                    ),
                  ),
                  FittedBox(child: const Text('Settings')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
