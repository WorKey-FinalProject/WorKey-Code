import 'package:flutter/material.dart';

import '../../widgets/profile_screen_widgets/profile_picture.dart';

enum TextFieldType {
  email,
  password,
  firstName,
  lastName,
}

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userFirstName = '';
  var _userLastName = '';
  var _userPassword = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField(
                      'First Name',
                      'From database',
                      TextFieldType.firstName,
                    ),
                    buildTextField(
                      'Last Name',
                      'From database',
                      TextFieldType.lastName,
                    ),
                    buildTextField(
                      'E-mail',
                      'From database',
                      TextFieldType.email,
                    ),
                    buildTextField(
                      'Password',
                      '********',
                      TextFieldType.password,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              RaisedButton(
                onPressed: () {},
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
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeHolder, TextFieldType textFieldType) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
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
