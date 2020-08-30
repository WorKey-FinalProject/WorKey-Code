import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/employees_list.dart';
import '../screens/groups_screen.dart';

class IconsRow extends StatefulWidget {
  final Function selectedIconHandler;

  IconsRow(this.selectedIconHandler);

  @override
  _IconsRowState createState() => _IconsRowState();
}

class _IconsRowState extends State<IconsRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: FlatButton(
                onPressed: () =>
                    widget.selectedIconHandler(SelectedIcon.employees),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      size: 35,
                    ),
                    FittedBox(child: const Text('Employees')),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: FlatButton(
                onPressed: () =>
                    widget.selectedIconHandler(SelectedIcon.employees),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.place,
                      size: 35,
                    ),
                    FittedBox(child: const Text('Location')),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: FlatButton(
                onPressed: () =>
                    widget.selectedIconHandler(SelectedIcon.employees),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.graph,
                      size: 35,
                    ),
                    FittedBox(child: const Text('Sub Groups')),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: FlatButton(
                onPressed: () =>
                    widget.selectedIconHandler(SelectedIcon.employees),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      size: 35,
                    ),
                    FittedBox(child: const Text('Settings')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
