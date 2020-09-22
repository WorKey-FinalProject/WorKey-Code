import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workey/general/models/company_account_model.dart';
import 'package:workey/general/providers/auth.dart';

import '../../widgets/profile_picture.dart';

enum TextFieldType {
  companyName,
  email,
  password,
  verifyPassword,
  firstName,
  lastName,
}

class PersonalInfoScreen extends StatefulWidget {
  final Auth auth;

  PersonalInfoScreen(this.auth);

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  CompanyAccountModel userAccount;
  var _isLoading = false;

  File _userImageFile;

  final companyNameTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final verifyPasswordTextController = TextEditingController();
  String _userImage;

  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();
  final _formKeyForPassword = GlobalKey<FormState>();

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      // CompanyAccountModel userAccount = CompanyAccountModel(
      //   companyEmail: emailTextController.text.trim(),
      //   companyName: companyNameTextController.text.trim(),
      //   owenrFirstName: firstNameTextController.text.trim(),
      //   owenrLastName: lastNameTextController.text.trim(),
      //   companyLogo: _userImageFile.toString(),
      // );
      userAccount.companyEmail = emailTextController.text.trim();
      userAccount.companyName = companyNameTextController.text.trim();
      userAccount.owenrFirstName = firstNameTextController.text.trim();
      userAccount.owenrLastName = lastNameTextController.text.trim();
      userAccount.companyLogo = _userImageFile.toString();
      try {
        await widget.auth.updateCurrUserData(userAccount);
      } on PlatformException catch (err) {
        var message = 'An error occurred';

        if (err.message != null) {
          message = err.message;
        }

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      } catch (err) {
        print(err);
      }
      Navigator.pop(context);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Changes saved successfully',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  Future<void> _tryChangePassword() async {
    final isValid = _formKeyForPassword.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKeyForPassword.currentState.save();
      try {
        await widget.auth
            .updateCurrUserPassword(passwordTextController.text.trim());
      } on PlatformException catch (err) {
        var message = 'An error occurred';

        if (err.message != null) {
          message = err.message;
        }

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      } catch (err) {
        print(err);
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Password changed successfully',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue,
        ),
      );
      Navigator.pop(context);
    }
  }

  void getUserData() async {
    setState(() {
      _isLoading = true;
    });
    userAccount = await widget.auth.getCurrUserData() as CompanyAccountModel;
    companyNameTextController.text = userAccount.companyName;
    firstNameTextController.text = userAccount.owenrFirstName;
    lastNameTextController.text = userAccount.owenrLastName;
    emailTextController.text = userAccount.companyEmail;
    passwordTextController.text = '';
    _userImage = userAccount.companyLogo;

    setState(() {
      _isLoading = false;
    });
  }

  void _selectImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

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
  void initState() {
    getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    ProfilePicture(
                      onSelectImage: _selectImage,
                      size: 150,
                      isEditable: true,
                      imageUrl: _userImage,
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
                                        child: SingleChildScrollView(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75,
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
                                                      TextFieldType
                                                          .verifyPassword,
                                                      verifyPasswordTextController,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          _tryChangePassword();
                                                        },
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Text(
                                                          'Confirm Change',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        behavior: HitTestBehavior.opaque,
                                      );
                                    },
                                  );
                                },
                                color: Colors.grey,
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
                    Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () {
                          loadingOnScreenIndicator(context);
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
                : textFieldType == TextFieldType.verifyPassword
                    ? (value) {
                        verifyPasswordTextController.text = value;
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
                : textFieldType == TextFieldType.verifyPassword
                    ? (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Please enter at least 7 characters';
                        }
                        if (passwordTextController.text != value) {
                          return 'Passwords do not match';
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
        obscureText: (textFieldType == TextFieldType.password ||
                textFieldType == TextFieldType.verifyPassword)
            ? showPassword
            : false,
        decoration: InputDecoration(
          suffixIcon: (textFieldType == TextFieldType.password ||
                  textFieldType == TextFieldType.verifyPassword)
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

  loadingOnScreenIndicator(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
