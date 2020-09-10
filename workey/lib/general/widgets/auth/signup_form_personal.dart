import 'package:flutter/material.dart';

import '../previous_next_button.dart';

class SignUpFormPersonal extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    BuildContext ctx,
  ) submitFn;

  SignUpFormPersonal(this.submitFn);

  @override
  _SignUpFormPersonalState createState() => _SignUpFormPersonalState();
}

class _SignUpFormPersonalState extends State<SignUpFormPersonal> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();

  var step = 0;
  var maxStep = 0;

  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  var _userFirstName = '';
  var _userLastName = '';

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
        context,
      );
    }
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

    return card1;
  }
}
