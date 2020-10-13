import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../general/providers/auth.dart';
// import '../../general/providers/company_groups.dart';
// import '../../general/widgets/auth/signup_type.dart';
// import '../../personal_account/screens/members_list_screen.dart';

// import '../../personal_account/screens/weekly_shifts_screen.dart';
import 'icons_grid_view.dart';

class GridViewIconButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final ButtonType buttonType;
  final Function onSelected;

  GridViewIconButton(
    this.iconData,
    this.title,
    this.buttonType,
    this.onSelected,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: FlatButton(
        onPressed: () => onSelected(context, buttonType),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.brown,
              size: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
