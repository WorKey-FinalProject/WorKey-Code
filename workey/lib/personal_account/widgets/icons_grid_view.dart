import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/screens/mail_box.dart';
import 'package:workey/general/widgets/auth/signup_type.dart';

import 'package:workey/general/widgets/location_input.dart';

import 'package:workey/personal_account/screens/members_list_screen.dart';
import 'package:workey/personal_account/screens/weekly_shifts_screen.dart';
import 'package:workey/personal_account/widgets/grid_view_icon_button.dart';

enum ButtonType {
  weeklyShifts,
  groupMembers,
  mailBox,
  location,
  notes,
  whatsApp,
}

class IconsGridView extends StatefulWidget {
  @override
  _IconsGridViewState createState() => _IconsGridViewState();
}

class _IconsGridViewState extends State<IconsGridView> {
  final _formKey = GlobalKey<FormState>();

  final whatsAppGroupLink = TextEditingController();

  AccountTypeChosen accountTypeChosen;

  ///Providers
  Auth _auth;
  CompanyGroups _companyGroups;

  void _onSelected(
    BuildContext context,
    ButtonType buttonType,
  ) {
    switch (buttonType) {
      case ButtonType.weeklyShifts:
        {
          Navigator.push(
            context,
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
            context,
            MaterialPageRoute(
              builder: (context) => MembersListScreen(),
            ),
          );
          print('Selected groupMembers button');
        }
        break;

      case ButtonType.mailBox:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MailBox(),
            ),
          );
          print('Selected mailBox button');
        }
        break;

      case ButtonType.location:
        {
          var _isExpanded = false;
          var _height = MediaQuery.of(context).size.height * 0.4;
          showModalBottomSheet(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            context: context,
            builder: (_) {
              return StatefulBuilder(
                builder: (context, setLocationModalState) {
                  return GestureDetector(
                    onTap: () {
                      setLocationModalState(() {
                        _isExpanded = !_isExpanded;
                        if (_isExpanded) {
                          _height = MediaQuery.of(context).size.height;
                        } else {
                          _height = MediaQuery.of(context).size.height * 0.4;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.fastOutSlowIn,
                      height: _height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: LocationInput(),
                    ),
                  );
                },
              );
            },
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => LocationInput(),
          //   ),
          // );
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
            addWhatsAppLinkShowDialog(context);
          } else {
            if (whatsAppGroupLink.text == null ||
                whatsAppGroupLink.text.isEmpty) {
              Fluttertoast.showToast(msg: "No link defined for WhatsApp group");
            } else {
              launchWhatsApp(
                whatsAppGroupLink: whatsAppGroupLink.text,
              );
              print('Selected whatsApp button');
            }
          }
        }
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<Auth>(context, listen: false);
    _companyGroups = Provider.of<CompanyGroups>(context, listen: false);

    accountTypeChosen = _auth.getAccountTypeChosen;
    whatsAppGroupLink.text = _companyGroups.getCurrentWorkGroup.whatsAppUrl;

    // List of Icons
    final List<Widget> iconsList = [
      GridViewIconButton(
        Icons.calendar_today_outlined,
        'Weekly Shifts',
        ButtonType.weeklyShifts,
        _onSelected,
      ),
      if (accountTypeChosen == AccountTypeChosen.personal)
        GridViewIconButton(
          Icons.group,
          'Members',
          ButtonType.groupMembers,
          _onSelected,
        ),
      GridViewIconButton(
        Icons.mail,
        'Mail Box',
        ButtonType.mailBox,
        _onSelected,
      ),
      GridViewIconButton(
        Icons.location_on,
        'Location',
        ButtonType.location,
        _onSelected,
      ),
      GridViewIconButton(
        Icons.notes,
        'Notes',
        ButtonType.notes,
        _onSelected,
      ),
      GridViewIconButton(
        MdiIcons.whatsapp,
        'WhatsApp',
        ButtonType.whatsApp,
        _onSelected,
      ),
    ];

    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: accountTypeChosen == AccountTypeChosen.company
          ? NeverScrollableScrollPhysics()
          : null,
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

  /// WhatsApp launch
  void launchWhatsApp({
    @required String whatsAppGroupLink,
  }) async {
    if (await canLaunch(whatsAppGroupLink)) {
      await launch(whatsAppGroupLink);
    } else {
      throw 'Could not launch $whatsAppGroupLink';
    }
  }

  /// WhatsApp Dialog
  Future addWhatsAppLinkShowDialog(
    BuildContext context,
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
                      _companyGroups.setWhatsAppUrl(value);
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
