import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconsRow extends StatefulWidget {
  final Function selectPage;

  IconsRow(this.selectPage);

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
                  onPressed: () => widget.selectPage(0)),
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
                  onPressed: () => widget.selectPage(0)),
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
                  onPressed: () => widget.selectPage(0)),
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
                  onPressed: () => widget.selectPage(0)),
              const Text('Settings'),
            ],
          ),
        ],
      ),
    );
  }
}
