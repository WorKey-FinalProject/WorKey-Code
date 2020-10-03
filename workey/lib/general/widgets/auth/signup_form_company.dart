import 'dart:io';

import 'package:flutter/material.dart';
import 'package:workey/general/widgets/profile_picture.dart';

import '../previous_next_button.dart';

class SignUpFormCompany extends StatefulWidget {
  final void Function({
    String email,
    String password,
    String firstName,
    String lastName,
    String companyName,
    File imageFile,
    BuildContext ctx,
  }) submitFn;

  SignUpFormCompany(this.submitFn);

  @override
  _SignUpFormCompanyState createState() => _SignUpFormCompanyState();
}

class _SignUpFormCompanyState extends State<SignUpFormCompany> {
  File _userImageFile;

  final companyNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final verifyPasswordTextController = TextEditingController();

  var step = 0;
  var maxStep = 1;

  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      print('$_userImageFile --------- trySubmit :: _userImageFile');
      _formKey.currentState.save();
      widget.submitFn(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
        firstName: firstNameTextController.text.trim(),
        lastName: lastNameTextController.text.trim(),
        companyName: companyNameTextController.text.trim(),
        imageFile: _userImageFile,
        ctx: context,
      );
    }
  }

  void _selectImage(File pickedImage) {
    _userImageFile = pickedImage;
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
  void dispose() {
    companyNameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    super.dispose();
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
                      /// Logo picture
                      ProfilePicture(
                        onSelectImage: _selectImage,
                        size: 150,
                        isEditable: true,
                        imageUrl: '',
                        keepImageFile: _userImageFile,
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      /// Company name
                      TextFormField(
                        controller: companyNameTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid company name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          companyNameTextController.text = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Company name',
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
                      /// Email
                      TextFormField(
                        controller: emailTextController,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailTextController.text = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      /// First name
                      TextFormField(
                        controller: firstNameTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your First name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          firstNameTextController.text = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'First name',
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      /// Last name
                      TextFormField(
                        controller: lastNameTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Last name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          lastNameTextController.text = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Last name',
                          icon: Icon(
                            Icons.person_outline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      /// password
                      TextFormField(
                        controller: passwordTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a password.';
                          }
                          if (value.length < 7) {
                            return 'Please enter at least 7 characters.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordTextController.text = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          labelText: 'Passsword',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      /// verify Password
                      TextFormField(
                        controller: verifyPasswordTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Password.';
                          }
                          if (value.length < 7) {
                            return 'Please enter at least 7 characters.';
                          }
                          if (passwordTextController.text != value) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          verifyPasswordTextController.text = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          ),
                          labelText: 'Verify Password',
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
