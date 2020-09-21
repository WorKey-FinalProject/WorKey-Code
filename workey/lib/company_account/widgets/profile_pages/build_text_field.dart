import 'package:flutter/material.dart';

import 'text_field_type.dart';

class BuildTextField extends StatefulWidget {
  String labelText;
  TextFieldType textFieldType;
  TextEditingController textEditingController;

  BuildTextField({
    this.labelText,
    this.textEditingController,
    this.textFieldType,
  });
  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  final companyNameTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final verifyPasswordTextController = TextEditingController();

  bool showPassword = true;

  @override
  void dispose() {
    companyNameTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    verifyPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: widget.textEditingController,
        onSaved: widget.textFieldType == TextFieldType.email
            ? (value) {
                emailTextController.text = value;
              }
            : widget.textFieldType == TextFieldType.password
                ? (value) {
                    passwordTextController.text = value;
                  }
                : widget.textFieldType == TextFieldType.verifyPassword
                    ? (value) {
                        verifyPasswordTextController.text = value;
                      }
                    : widget.textFieldType == TextFieldType.firstName
                        ? (value) {
                            firstNameTextController.text = value;
                          }
                        : widget.textFieldType == TextFieldType.lastName
                            ? (value) {
                                lastNameTextController.text = value;
                              }
                            : null,
        validator: widget.textFieldType == TextFieldType.email
            ? (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return null;
              }
            : widget.textFieldType == TextFieldType.password
                ? (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Please enter at least 7 characters';
                    }
                    return null;
                  }
                : widget.textFieldType == TextFieldType.verifyPassword
                    ? (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Please enter at least 7 characters';
                        }
                        if (passwordTextController.text != value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      }
                    : widget.textFieldType == TextFieldType.firstName
                        ? (value) {
                            if (value.isEmpty) {
                              return 'Please enter your First name.';
                            }
                            return null;
                          }
                        : widget.textFieldType == TextFieldType.lastName
                            ? (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Last name.';
                                }
                                return null;
                              }
                            : null,
        obscureText: (widget.textFieldType == TextFieldType.password ||
                widget.textFieldType == TextFieldType.verifyPassword)
            ? showPassword
            : false,
        decoration: InputDecoration(
          suffixIcon: (widget.textFieldType == TextFieldType.password ||
                  widget.textFieldType == TextFieldType.verifyPassword)
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
          labelText: widget.labelText,
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
