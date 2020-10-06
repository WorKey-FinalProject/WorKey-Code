import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workey/personal_account/screens/members_screen.dart';

import '../../personal_account/screens/weekly_shifts_screen.dart';
import 'icons_grid_view.dart';

class GridViewIconButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final ButtonType buttonType;
  final BuildContext ctx;

  GridViewIconButton(
    this.iconData,
    this.title,
    this.buttonType,
    this.ctx,
  );

  void _onSelected() {
    switch (buttonType) {
      case ButtonType.weeklyShifts:
        {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) => WeeklyShiftsScreen(),
            ),
          );
          print('Selected weeklyShifts button');
        }
        break;

      case ButtonType.groupMembers:
        {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) => MembersScreen(),
            ),
          );
          print('Selected groupMembers button');
        }
        break;

      case ButtonType.mailBox:
        {
          print('Selected mailBox button');
        }
        break;

      case ButtonType.location:
        {
          print('Selected location button');
        }
        break;

      case ButtonType.notes:
        {
          print('Selected notes button');
        }
        break;

      case ButtonType.whatsApp:
        {
          launchWhatsApp(
              whatsAppGroupLink:
                  'https://chat.whatsapp.com/JE5j9myLjf9EfWCmnCnAZR');
          print('Selected whatsApp button');
        }
        break;

      default:
        break;
    }
    // if (buttonType == ButtonType.weeklyShifts) {
    //   Navigator.push(
    //     ctx,
    //     MaterialPageRoute(
    //       builder: (context) => WeeklyShiftsScreen(),
    //     ),
    //   );
    //   print('Selected weeklyShifts button');
    // }
    // if (buttonType == ButtonType.groupMembers) {
    //   print('Selected groupMembers button');
    // }
    // if (buttonType == ButtonType.mailBox) {
    //   print('Selected mailBox button');
    // }
    // if (buttonType == ButtonType.location) {
    //   print('Selected location button');
    // }
    // if (buttonType == ButtonType.codes) {
    //   print('Selected codes button');
    // }
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

  void launchWhatsApp({
    // @required String phone,
    // @required String message,
    @required String whatsAppGroupLink,
  }) async {
    // String url() {
    //   if (Platform.isIOS) {
    //     return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
    //   } else {
    //     return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
    //   }
    // }

    if (await canLaunch(whatsAppGroupLink)) {
      await launch(whatsAppGroupLink);
    } else {
      throw 'Could not launch $whatsAppGroupLink';
    }
  }
}
