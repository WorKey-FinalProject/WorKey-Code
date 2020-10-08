import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:workey/general/widgets/date_picker.dart';

import '../../general/models/personal_account_model.dart';
import '../../general/providers/auth.dart';
import '../../general/widgets/profile_picture.dart';

enum TextFieldType {
  email,
  password,
  verifyPassword,
  firstName,
  lastName,
  phoneNumber,
  dateOfBirth,
  address,
}

class ProfileForm extends StatefulWidget {
  final Auth auth;

  ProfileForm(this.auth);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  PersonalAccountModel userAccount;
  var _isLoading = false;

  File _userImageFile;

  final emailTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final verifyPasswordTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final dateOfBirthTextController = TextEditingController();
  final addressTextController = TextEditingController();

  String _userImage;

  var showPassword = true;
  var showVerifyPassword = true;

  final _formKey = GlobalKey<FormState>();
  final _formKeyForPassword = GlobalKey<FormState>();

  Function _setModalState;

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      userAccount.email = emailTextController.text.trim();
      userAccount.firstName = firstNameTextController.text.trim();
      userAccount.lastName = lastNameTextController.text.trim();
      userAccount.phoneNumber = phoneNumberTextController.text.trim();
      userAccount.address = addressTextController.text.trim();
      userAccount.dateOfBirth = dateOfBirthTextController.text.trim();
      userAccount.setImageFile(_userImageFile);
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
      passwordTextController.text = '';
      verifyPasswordTextController.text = '';
    }
  }

  void getUserData() async {
    setState(() {
      _isLoading = true;
    });
    userAccount = await widget.auth.getCurrUserData() as PersonalAccountModel;
    emailTextController.text = userAccount.email;
    firstNameTextController.text = userAccount.firstName;
    lastNameTextController.text = userAccount.lastName;
    passwordTextController.text = '';
    phoneNumberTextController.text = userAccount.phoneNumber;
    dateOfBirthTextController.text = userAccount.dateOfBirth;
    addressTextController.text = userAccount.address;
    _userImage = userAccount.profilePicture;

    setState(() {
      _isLoading = false;
    });
  }

  void _selectImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  @override
  void dispose() {
    emailTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    passwordTextController.dispose();
    verifyPasswordTextController.dispose();
    phoneNumberTextController.dispose();
    dateOfBirthTextController.dispose();
    addressTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getUserData();

    super.initState();
  }

  void _selectedDate(DateTime dateTime) {
    dateOfBirthTextController.text = DateFormat.yMd().format(dateTime);
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
                              'E-mail',
                              TextFieldType.email,
                              emailTextController,
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
                              'Phone Number',
                              TextFieldType.phoneNumber,
                              phoneNumberTextController,
                            ),
                            buildTextField(
                              'Address',
                              TextFieldType.address,
                              addressTextController,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: DatePicker(
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime.now(),
                                labelText: 'Date of Birth',
                                selectedDate: _selectedDate,
                              ),
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
                                      return StatefulBuilder(
                                        builder: (context, setModalState) {
                                          _setModalState = setModalState;
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
                                                          TextFieldType
                                                              .password,
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
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: RaisedButton(
                                                            onPressed: () {
                                                              _tryChangePassword();
                                                            },
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
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
                            : textFieldType == TextFieldType.phoneNumber
                                ? (value) {
                                    phoneNumberTextController.text = value;
                                  }
                                : textFieldType == TextFieldType.dateOfBirth
                                    ? (value) {
                                        dateOfBirthTextController.text = value;
                                      }
                                    : textFieldType == TextFieldType.address
                                        ? (value) {
                                            addressTextController.text = value;
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
        obscureText: textFieldType == TextFieldType.password
            ? showPassword
            : textFieldType == TextFieldType.verifyPassword
                ? showVerifyPassword
                : false,
        keyboardType: textFieldType == TextFieldType.email
            ? TextInputType.emailAddress
            : textFieldType == TextFieldType.password
                ? TextInputType.visiblePassword
                : textFieldType == TextFieldType.verifyPassword
                    ? TextInputType.visiblePassword
                    : textFieldType == TextFieldType.firstName
                        ? TextInputType.name
                        : textFieldType == TextFieldType.lastName
                            ? TextInputType.name
                            : textFieldType == TextFieldType.phoneNumber
                                ? TextInputType.phone
                                : textFieldType == TextFieldType.dateOfBirth
                                    ? TextInputType.datetime
                                    : textFieldType == TextFieldType.address
                                        ? TextInputType.streetAddress
                                        : null,
        decoration: InputDecoration(
          suffixIcon: (textFieldType == TextFieldType.password ||
                  textFieldType == TextFieldType.verifyPassword)
              ? IconButton(
                  onPressed: () {
                    _setModalState(() {
                      if (textFieldType == TextFieldType.password) {
                        showPassword = !showPassword;
                      }
                      if (textFieldType == TextFieldType.verifyPassword) {
                        showVerifyPassword = !showVerifyPassword;
                      }
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
