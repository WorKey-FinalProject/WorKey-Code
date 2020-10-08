import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../general/providers/auth.dart';
import '../../general/providers/company_groups.dart';
import '../../general/widgets/auth/signup_type.dart';
import '../../personal_account/screens/members_list_screen.dart';

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

  final _formKey = GlobalKey<FormState>();

  final whatsAppGroupLink = TextEditingController();
  AccountTypeChosen accountTypeChosen;

  void _onSelected(
    BuildContext context,
    CompanyGroups companyGroups,
    Auth auth,
  ) {
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
              builder: (context) => MembersListScreen(),
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
          if (accountTypeChosen == AccountTypeChosen.company) {
            addWhatsAppLinkShowDialog(context, _formKey, companyGroups);
          } else {
            launchWhatsApp(whatsAppGroupLink: whatsAppGroupLink.text
                //'https://chat.whatsapp.com/JE5j9myLjf9EfWCmnCnAZR',
                );
            print('Selected whatsApp button');
          }
        }
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyGroups = Provider.of<CompanyGroups>(context, listen: false);
    final _auth = Provider.of<Auth>(context, listen: false);
    whatsAppGroupLink.text = companyGroups.getCurrentWorkGroup.whatsAppUrl;
    accountTypeChosen = _auth.getAccountTypeChosen;

    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: FlatButton(
        onPressed: () => _onSelected(context, companyGroups, _auth),
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

  Future addWhatsAppLinkShowDialog(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    CompanyGroups companyGroupsProvider,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    controller: whatsAppGroupLink,
                    decoration: InputDecoration(
                      labelText: 'whatsApp group link',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      whatsAppGroupLink.text = value;
                      companyGroupsProvider.setWhatsAppUrl(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a WhatsApp link';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 8.0,
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        final isValid = _formKey.currentState.validate();
                        if (isValid) {
                          Navigator.pop(context);
                          _formKey.currentState.save();
                        }
                      },
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Save"),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        final isValid = _formKey.currentState.validate();
                        if (isValid) {
                          launchWhatsApp(
                              whatsAppGroupLink: whatsAppGroupLink.text);
                        }
                      },
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Go to group"),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
