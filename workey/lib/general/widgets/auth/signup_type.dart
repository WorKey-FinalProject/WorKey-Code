import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../general/widgets/auth/signup_form_company.dart';
import '../../../general/widgets/auth/signup_form_personal.dart';

import '../back_button_widget.dart';

enum AccountTypeChosen {
  nothing,
  company,
  personal,
}

class SignUpType extends StatefulWidget {
  final void Function({
    String email,
    String password,
    String firstName,
    String lastName,
    String companyName,
    File imageFile,
    BuildContext ctx,
  }) submitFnCompany;

  final void Function({
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String dateOfBirth,
    String address,
    File imageFile,
    BuildContext ctx,
  }) submitFnPersonal;

  SignUpType(this.submitFnCompany, this.submitFnPersonal);

  @override
  _SignUpTypeState createState() => _SignUpTypeState();
}

class _SignUpTypeState extends State<SignUpType> {
  AccountTypeChosen accountTypeChosen = AccountTypeChosen.nothing;

  String onImageText = 'Create New Account';

  @override
  Widget build(BuildContext context) {
    var accountTypeSelection = Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                accountTypeChosen = AccountTypeChosen.company;
                onImageText = 'Company Account';
              });
            },
            child: AccountSelection(
              title: 'Company Account',
              description:
                  '• Arranging weekly schedule. \n• Managing working groups. \n• Monitoring employees shifts.',
              color: Colors.grey[400],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                accountTypeChosen = AccountTypeChosen.personal;
                onImageText = 'Personal Account';
              });
            },
            child: AccountSelection(
              title: 'Personal Account',
              description:
                  '• Check in and out work. \n• Keep track of shift details. \n• Choosing a desired work arrangement.',
              color: Colors.black45,
            ),
          ),
        ),
      ],
    );

    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: BackButtonWidget(text: onImageText),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: accountTypeChosen == AccountTypeChosen.nothing
              ? accountTypeSelection
              : accountTypeChosen == AccountTypeChosen.company
                  ? SignUpFormCompany(widget.submitFnCompany)
                  : SignUpFormPersonal(widget.submitFnPersonal),
        ),
      ],
    );
  }
}

class AccountSelection extends StatelessWidget {
  const AccountSelection({
    Key key,
    @required this.title,
    @required this.description,
    @required this.color,
  }) : super(key: key);

  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                fontSize: 40,
              ),
            ),
            Divider(),
            Text(
              description,
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
