import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/company_account_model.dart';
import 'package:workey/general/providers/auth.dart';

import '../../widgets/profile_screen_widgets/profile_picture.dart';

enum TextFieldType {
  companyName,
  email,
  password,
  firstName,
  lastName,
}

class PersonalInfoScreen extends StatefulWidget {
  Auth auth;

  PersonalInfoScreen(this.auth);

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final companyNameTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final verifyPasswordTextController = TextEditingController();

  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();
  final _formKeyForPassword = GlobalKey<FormState>();

  CompanyAccountModel userAccount;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      userAccount.companyEmail = emailTextController.text;
      widget.auth.updateCurrUserData(userAccount);
    }
  }

  void _tryChangePassword() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKeyForPassword.currentState.save();
      //userAccount.companyEmail = emailTextController.text;
      //widget.auth.updateCurrUserData(userAccount);
    }
  }

  void getUserData() async {
    userAccount = await widget.auth.getCurrUserData();
    companyNameTextController.text = userAccount.companyName;
    firstNameTextController.text = userAccount.owenrFirstName;
    lastNameTextController.text = userAccount.owenrLastName;
    emailTextController.text = userAccount.companyEmail;
    passwordTextController.text = '';
  }

  @override
  void initState() {
    getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(90),
                onTap: () {},
                child: ProfilePicture(
                  imageUrl:
                      'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                  size: 150,
                  isEditable: true,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField(
                      'Company Name',
                      TextFieldType.companyName,
                      companyNameTextController,
                    ),
                    buildTextField(
                      'First Name',
                      TextFieldType.firstName,
                      firstNameTextController,
                    ),
                    buildTextField(
                      'Last Name',
                      TextFieldType.lastName,
                      lastNameTextController,
                    ),
                    buildTextField(
                      'E-mail',
                      TextFieldType.email,
                      emailTextController,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: () {
                          showModalBottomSheet(
                            elevation: 5,
                            context: context,
                            builder: (_) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Form(
                                    key: _formKeyForPassword,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: buildTextField(
                                            'New Password',
                                            TextFieldType.password,
                                            passwordTextController,
                                          ),
                                        ),
                                        Flexible(
                                          child: buildTextField(
                                            'Verify Password',
                                            TextFieldType.password,
                                            verifyPasswordTextController,
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            alignment: Alignment.bottomRight,
                                            padding: EdgeInsets.all(20),
                                            child: RaisedButton(
                                              onPressed: () {
                                                _tryChangePassword();
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                'Confirm Change',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                behavior: HitTestBehavior.opaque,
                              );
                            },
                          );
                        },
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Change password'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {
                  _trySubmit();
                },
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
    String labelText,
    TextFieldType textFieldType,
    TextEditingController textEditingController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: textEditingController,
        onSaved: textFieldType == TextFieldType.email
            ? (value) {
                emailTextController.text = value;
              }
            : textFieldType == TextFieldType.password
                ? (value) {
                    passwordTextController.text = value;
                  }
                : textFieldType == TextFieldType.firstName
                    ? (value) {
                        firstNameTextController.text = value;
                      }
                    : textFieldType == TextFieldType.lastName
                        ? (value) {
                            lastNameTextController.text = value;
                          }
                        : null,
        validator: textFieldType == TextFieldType.email
            ? (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return null;
              }
            : textFieldType == TextFieldType.password
                ? (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Please enter at least 7 characters';
                    }
                    return null;
                  }
                : textFieldType == TextFieldType.firstName
                    ? (value) {
                        if (value.isEmpty) {
                          return 'Please enter your First name.';
                        }
                        return null;
                      }
                    : textFieldType == TextFieldType.lastName
                        ? (value) {
                            if (value.isEmpty) {
                              return 'Please enter your Last name.';
                            }
                            return null;
                          }
                        : null,
        obscureText:
            textFieldType == TextFieldType.password ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: textFieldType == TextFieldType.password
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
