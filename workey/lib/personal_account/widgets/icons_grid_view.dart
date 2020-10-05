import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:workey/personal_account/widgets/grid_view_icon_button.dart';

enum ButtonType {
  weeklyShifts,
  groupMembers,
  mailBox,
  location,
  notes,
  whatsApp,
}

class IconsGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> iconsList = [
      GridViewIconButton(
        Icons.calendar_today_outlined,
        'Weekly Shifts',
        ButtonType.weeklyShifts,
        context,
      ),
      GridViewIconButton(
        Icons.group,
        'Members',
        ButtonType.groupMembers,
        context,
      ),
      GridViewIconButton(
        Icons.mail,
        'Mail Box',
        ButtonType.mailBox,
        context,
      ),
      GridViewIconButton(
        Icons.location_on,
        'Location',
        ButtonType.location,
        context,
      ),
      GridViewIconButton(
        Icons.notes,
        'Notes',
        ButtonType.notes,
        context,
      ),
      GridViewIconButton(
        MdiIcons.whatsapp,
        'WhatsApp',
        ButtonType.whatsApp,
        context,
      ),
    ];

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
