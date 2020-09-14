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
  final emailNameTextController = TextEditingController();
  final passwordNameTextController = TextEditingController();
  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userFirstName = '';
  var _userLastName = '';
  var _userPassword = '';

  CompanyAccountModel companyAccountModel;

  void getUserData() async {
    companyAccountModel = await widget.auth.getCurrUserData().then((value) {
      print('${value.companyEmail} @@@@@@@@@@@@@@@@@');
    });
  }

  // @override
  // void initState() {
  //   getUserData();
  //   companyNameTextController.text = 'company name';
  //   firstNameTextController.text = 'first name';
  //   lastNameTextController.text = 'last name';
  //   emailNameTextController.text = 'email address';
  //   passwordNameTextController.text = 'password';

  //   super.initState();
  // }

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
                child: ProfilePicture(),
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
                      'From database',
                      TextFieldType.companyName,
                      companyNameTextController,
                    ),
                    buildTextField(
                      'First Name',
                      'From database',
                      TextFieldType.firstName,
                      firstNameTextController,
                    ),
                    buildTextField(
                      'Last Name',
                      'From database',
                      TextFieldType.lastName,
                      lastNameTextController,
                    ),
                    buildTextField(
                      'E-mail',
                      'From database',
                      TextFieldType.email,
                      emailNameTextController,
                    ),
                    buildTextField(
                      'Password',
                      '********',
                      TextFieldType.password,
                      passwordNameTextController,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            RaisedButton(
              onPressed: () {
                getUserData();
              },
              padding: EdgeInsets.symmetric(horizontal: 50),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                'SAVE',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 2.2,
                  color: Colors.white,
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
    String placeHolder,
    TextFieldType textFieldType,
    TextEditingController textEditingController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: textEditingController,
        onSaved: textFieldType == TextFieldType.email
            ? (value) {
                _userEmail = value;
              }
            : textFieldType == TextFieldType.password
                ? (value) {
                    _userPassword = value;
                  }
                : textFieldType == TextFieldType.firstName
                    ? (value) {
                        _userFirstName = value;
                      }
                    : textFieldType == TextFieldType.lastName
                        ? (value) {
                            _userLastName = value;
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
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
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
