import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                onPressed: null),
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
                onPressed: null),
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
                onPressed: null),
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
                onPressed: null),
            const Text('Settings'),
          ],
        ),
      ],
    );
  }
}
