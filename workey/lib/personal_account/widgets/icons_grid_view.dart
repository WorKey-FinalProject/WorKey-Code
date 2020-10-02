import 'package:flutter/material.dart';
import 'package:workey/personal_account/widgets/grid_view_icon_button.dart';

enum ButtonType {
  weeklyShifts,
  codes,
}

class IconsGridView extends StatelessWidget {
  final List<Widget> iconsList = [
    GridViewIconButton(
      Icons.calendar_today_outlined,
      'Weekly Shifts',
      ButtonType.weeklyShifts,
    ),
    GridViewIconButton(
      Icons.storage,
      'Codes',
      ButtonType.codes,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return GridTile(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(36),
            ),
            child: iconsList[index],
          ),
        );
      },
      itemCount: iconsList.length,
    );
  }
}
