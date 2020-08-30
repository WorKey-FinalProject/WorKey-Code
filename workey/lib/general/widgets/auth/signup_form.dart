import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AccountTypeChosen {
  nothing,
  company,
  personal,
}

class SignUpForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    BuildContext ctx,
    AccountTypeChosen accountTypeChosen,
  ) submitFn;

  SignUpForm(this.submitFn);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  AccountTypeChosen accountTypeChosen = AccountTypeChosen.nothing;

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
        accountTypeChosen,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = Padding(
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
              SizedBox(
                height: 40,
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
                      onPressed: _trySubmit,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    var accountTypeSelection = Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              accountTypeChosen = AccountTypeChosen.company;
            });
          },
          child: AccountSelectionCard(
            title: 'Company Account',
            description: 'Description',
            color: Colors.amber,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              accountTypeChosen = AccountTypeChosen.personal;
            });
          },
          child: AccountSelectionCard(
            title: 'Personal Account',
            description: 'Description',
            color: Colors.green,
          ),
        ),
      ],
    );

    return ListView(
      children: <Widget>[
        BackButtonWidget(),
        accountTypeChosen == AccountTypeChosen.nothing
            ? accountTypeSelection
            : form,
      ],
    );
  }
}

class AccountSelectionCard extends StatelessWidget {
  const AccountSelectionCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.color,
  }) : super(key: key);

  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.all(10),
      height: 200,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  fontSize: 40,
                ),
              ),
              Divider(),
              Text(
                description,
                style: GoogleFonts.aBeeZee(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
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