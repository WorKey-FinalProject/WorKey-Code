import 'package:flutter/material.dart';

import 'icons_grid_view.dart';

class GridViewIconButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final ButtonType buttonType;

  GridViewIconButton(
    this.iconData,
    this.title,
    this.buttonType,
  );

  void _onSelected() {
    if (buttonType == ButtonType.weeklyShifts) {
      print('Selected weeklyShifts button');
    }
    if (buttonType == ButtonType.groupMembers) {
      print('Selected groupMembers button');
    }
    if (buttonType == ButtonType.mailBox) {
      print('Selected mailBox button');
    }
    if (buttonType == ButtonType.location) {
      print('Selected location button');
    }
    if (buttonType == ButtonType.codes) {
      print('Selected codes button');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: FlatButton(
        onPressed: _onSelected,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: Theme.of(context).primaryColor,
              size: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
