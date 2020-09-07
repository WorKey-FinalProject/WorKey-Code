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
  // var step = 0;

  // final _formKey = GlobalKey<FormState>();
  // var _userEmail = '';
  // var _userPassword = '';
  // var _userFirstName = '';
  // var _userLastName = '';
  // var _companyName = "";
  // var _companyLogoImagePath = "";

  // void _trySubmit() {
  //   final isValid = _formKey.currentState.validate();
  //   FocusScope.of(context).unfocus();

  //   if (isValid) {
  //     _formKey.currentState.save();
  //     widget.submitFn(
  //       _userEmail.trim(),
  //       _userPassword.trim(),
  //       _userFirstName.trim(),
  //       _userLastName.trim(),
  //       _companyName.trim(),
  //       _companyLogoImagePath.trim(),
  //       context,
  //       accountTypeChosen,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // var form = SingleChildScrollView(
    //   child: Container(
    //     padding: const EdgeInsets.all(20),
    //     height: MediaQuery.of(context).size.height,
    //     child: Column(
    //       children: [
    //         Flexible(
    //           fit: FlexFit.tight,
    //           child: Form(
    //             key: _formKey,
    //             child: Container(
    //               margin: EdgeInsets.only(left: 4, right: 20),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: <Widget>[
    //                   TextFormField(
    //                     validator: (value) {
    //                       if (value.isEmpty || !value.contains('@')) {
    //                         return 'Please enter a valid email address.';
    //                       }
    //                       return null;
    //                     },
    //                     onSaved: (value) {
    //                       _userEmail = value;
    //                     },
    //                     keyboardType: TextInputType.emailAddress,
    //                     decoration: InputDecoration(
    //                       hintText: 'Email',
    //                       icon: Icon(
    //                         Icons.mail,
    //                         color: Colors.black,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 30,
    //                   ),
    //                   TextFormField(
    //                     validator: (value) {
    //                       if (value.isEmpty) {
    //                         return 'Please enter your First name.';
    //                       }
    //                       return null;
    //                     },
    //                     onSaved: (value) {
    //                       _userFirstName = value;
    //                     },
    //                     keyboardType: TextInputType.emailAddress,
    //                     decoration: InputDecoration(
    //                       hintText: 'First name',
    //                       icon: Icon(
    //                         Icons.person,
    //                         color: Colors.black,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 30,
    //                   ),
    //                   TextFormField(
    //                     validator: (value) {
    //                       if (value.isEmpty) {
    //                         return 'Please enter your Last name.';
    //                       }
    //                       return null;
    //                     },
    //                     onSaved: (value) {
    //                       _userLastName = value;
    //                     },
    //                     keyboardType: TextInputType.emailAddress,
    //                     decoration: InputDecoration(
    //                       hintText: 'Last name',
    //                       icon: Icon(
    //                         Icons.person,
    //                         color: Colors.black,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 30,
    //                   ),
    //                   TextFormField(
    //                     validator: (value) {
    //                       if (value.isEmpty || value.length < 6) {
    //                         return 'Please enter a valid Password.';
    //                       }
    //                       return null;
    //                     },
    //                     onSaved: (value) {
    //                       _userPassword = value;
    //                     },
    //                     obscureText: true,
    //                     decoration: InputDecoration(
    //                       icon: Icon(
    //                         Icons.lock,
    //                         color: Colors.black,
    //                       ),
    //                       hintText: 'Passsword',
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Flexible(
    //           flex: 1,
    //           fit: FlexFit.tight,
    //           child: Container(
    //             alignment: Alignment.bottomCenter,
    //             child: Padding(
    //               padding: const EdgeInsets.all(20.0),
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(5),
    //                 child: Container(
    //                   height: 60,
    //                   width: double.infinity,
    //                   child: RaisedButton(
    //                     color: Theme.of(context).buttonColor,
    //                     child: Text(
    //                       'SIGN UP',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 20,
    //                       ),
    //                     ),
    //                     onPressed: _trySubmit,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

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
