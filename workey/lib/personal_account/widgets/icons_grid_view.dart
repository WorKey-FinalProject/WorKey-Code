import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/widgets/auth/signup_type.dart';
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
    final _auth = Provider.of<Auth>(context, listen: false);
    AccountTypeChosen accountTypeChosen = _auth.getAccountTypeChosen;
    final List<Widget> iconsList = [
      GridViewIconButton(
        Icons.calendar_today_outlined,
        'Weekly Shifts',
        ButtonType.weeklyShifts,
        context,
      ),
      if (accountTypeChosen == AccountTypeChosen.personal)
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
          child: Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            color: Colors.amberAccent,
            shape: RoundedRectangleBorder(
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
