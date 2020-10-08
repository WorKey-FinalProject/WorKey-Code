import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workey/general/widgets/profile_picture.dart';
import '../date_picker.dart';
import '../previous_next_button.dart';

class SignUpFormPersonal extends StatefulWidget {
  final void Function({
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String dateOfBirth,
    String address,
    File imageFile,
    BuildContext ctx,
  }) submitFn;

  SignUpFormPersonal(this.submitFn);

  @override
  _SignUpFormPersonalState createState() => _SignUpFormPersonalState();
}

class _SignUpFormPersonalState extends State<SignUpFormPersonal> {
  File _userImageFile;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final verifyPasswordTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final addressController = TextEditingController();

  var step = 0;
  var maxStep = 1;

  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
        firstName: firstNameTextController.text.trim(),
        lastName: lastNameTextController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        dateOfBirth: dateOfBirthController.text.trim(),
        address: addressController.text.trim(),
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

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        dateOfBirthController.text = DateFormat.yMd().format(_selectedDate);
      });
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 4, right: 20),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /// email Address
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
                        height: 30,
                      ),

                      /// password
                      TextFormField(
                        controller: passwordTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Password.';
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
                        height: 30,
                      ),

                      /// verify Password
                      TextFormField(
                        controller: verifyPasswordTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a password.';
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
                      SizedBox(
                        height: 30,
                      ),
                      ProfilePicture(
                        onSelectImage: _selectImage,
                        size: 150,
                        isEditable: true,
                        imageUrl: '',
                        keepImageFile: _userImageFile,
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
                      /// first Name
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

                      /// last Name
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

                      /// Phone Number
                      TextFormField(
                        controller: phoneNumberController,
                        onSaved: (value) {
                          phoneNumberController.text = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          counterText: 'Optional',
                          counterStyle: TextStyle(color: Colors.orange),
                          icon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      /// Date of birth
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: DatePicker(
                      //     firstDate: DateTime(DateTime.now().year - 100),
                      //     lastDate: DateTime.now(),
                      //     labelText: 'Date of Birth',
                      //     selectedDate: _selectedDate,
                      //   ),
                      // ),
                      TextFormField(
                        readOnly: true,
                        controller: dateOfBirthController,
                        onTap: _presentDatePicker,
                        onSaved: (value) {
                          dateOfBirthController.text = value;
                        },
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Date of birth',
                          counterText: 'Optional',
                          counterStyle: TextStyle(color: Colors.orange),
                          icon: Icon(
                            Icons.date_range,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      /// address
                      TextFormField(
                        controller: addressController,
                        onSaved: (value) {
                          addressController.text = value;
                        },
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          counterText: 'Optional',
                          counterStyle: TextStyle(color: Colors.orange),
                          icon: Icon(
                            Icons.house_outlined,
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

    return step == 0
        ? card1
        : step == 1
            ? card2
            : card2;
  }
}
