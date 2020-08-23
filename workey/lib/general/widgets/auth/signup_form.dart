import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    BuildContext ctx,
  ) submitFn;

  SignUpForm(this.submitFn);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        BackButtonWidget(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(left: 4, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
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
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Please enter at least 7 characters';
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
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 60,
              child: RaisedButton(
                color: Theme.of(context).buttonColor,
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onPressed: _trySubmit,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 60,
              child: RaisedButton(
                color: Theme.of(context).buttonColor,
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://www.druid.fi/sites/default/files/laptop-desk-table-coffee-light-wood-912411-pxhere.com__0.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Create New Account',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
