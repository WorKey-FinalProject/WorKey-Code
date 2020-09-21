import 'dart:io';

import 'package:flutter/material.dart';
import 'package:workey/company_account/widgets/profile_picture.dart';

import '../previous_next_button.dart';

class SignUpFormCompany extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    String companyName,
    String companyLogo,
    BuildContext ctx,
  ) submitFn;

  SignUpFormCompany(this.submitFn);

  @override
  _SignUpFormCompanyState createState() => _SignUpFormCompanyState();
}

class _SignUpFormCompanyState extends State<SignUpFormCompany> {
  File _pickedImage;

  final companyNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();

  var step = 0;
  var maxStep = 1;

  final _formKey = GlobalKey<FormState>();

  var _userEmail = '';
  var _userPassword = '';
  var _userFirstName = '';
  var _userLastName = '';
  var _companyName = "";
  var _companyLogoImagePath = "";

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userFirstName.trim(),
        _userLastName.trim(),
        _companyName.trim(),
        _companyLogoImagePath.trim(),
        context,
      );
    }
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _changeStep(int step) {
    if (step >= maxStep + 1) {
      _trySubmit();
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    setState(() {
      this.step = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    var card1 = Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: ProfilePicture(
              onSelectImage: _selectImage,
              size: 150,
              isEditable: true,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 4, right: 20),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: companyNameTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid company name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _companyName = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter the company name',
                          icon: Icon(
                            Icons.business,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          PreviousNextButton(
            changeStep: _changeStep,
            currStep: step,
            maxStep: maxStep,
            formKey: _formKey,
          ),
        ],
      ),
    );

    var card2 = Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 4, right: 20),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: emailTextController,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userEmail = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          icon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: firstNameTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your First name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userFirstName = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'First name',
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: lastNameTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Last name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userLastName = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Last name',
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordTextController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return 'Please enter a valid Password.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          hintText: 'Passsword',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          PreviousNextButton(
            changeStep: _changeStep,
            currStep: step,
            maxStep: maxStep,
            formKey: _formKey,
          ),
        ],
      ),
    );

    return step == 0 ? card1 : step == 1 ? card2 : card2;
  }
}
