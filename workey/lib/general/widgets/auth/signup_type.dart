import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workey/general/models/company_account_model.dart';
import 'package:workey/general/models/personal_account_model.dart';
import 'package:workey/general/widgets/auth/signup_form_company.dart';
import 'package:workey/general/widgets/auth/signup_form_personal.dart';

import '../back_button_widget.dart';
import '../previous_next_button.dart';

enum AccountTypeChosen {
  nothing,
  company,
  personal,
}

class SignUpType extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    String companyName,
    String companyLogo,
    BuildContext ctx,
  ) submitFnCompany;

  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    BuildContext ctx,
  ) submitFnPersonal;

  SignUpType(this.submitFnCompany, this.submitFnPersonal);

  @override
  _SignUpTypeState createState() => _SignUpTypeState();
}

class _SignUpTypeState extends State<SignUpType> {
  AccountTypeChosen accountTypeChosen = AccountTypeChosen.nothing;

  @override
  Widget build(BuildContext context) {
    var accountTypeSelection = Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: InkWell(
            onTap: () {
              setState(() {
                accountTypeChosen = AccountTypeChosen.company;
              });
            },
            child: AccountSelection(
              title: 'Company Account',
              description: 'Description',
              color: Colors.grey[400],
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: InkWell(
            onTap: () {
              setState(() {
                accountTypeChosen = AccountTypeChosen.personal;
              });
            },
            child: AccountSelection(
              title: 'Personal Account',
              description: 'Description',
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
          child: BackButtonWidget(),
        ),
        Flexible(
          flex: 2,
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
