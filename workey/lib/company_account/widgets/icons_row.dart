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
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.people,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () =>
                    widget.selectedIconHandler(SelectedIcon.employees),
              ),
              const Text('Employees'),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.place,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () =>
                    widget.selectedIconHandler(SelectedIcon.location),
              ),
              const Text('Location'),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                iconSize: 30,
                icon: Icon(
                  MdiIcons.graph,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () =>
                    widget.selectedIconHandler(SelectedIcon.subGroups),
              ),
              const Text('Sub Groups'),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () =>
                    widget.selectedIconHandler(SelectedIcon.settings),
              ),
              const Text('Settings'),
            ],
          ),
        ],
      ),
    );
  }
}
