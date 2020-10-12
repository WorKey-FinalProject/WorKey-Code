import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../general/screens/signup_screen.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    Function updateLoadingStatus,
    BuildContext ctx,
  ) submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';

  var _isLoading = false;

  void updateLoadingStatus(bool isLoading) {
    if (this.mounted) {
      setState(() {
        _isLoading = isLoading;
      });
    }
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        updateLoadingStatus,
        context,
      );
    }
  }

  // Future<bool> _googleSignIn() async {
  //   final googleSignIn = GoogleSignIn();
  //   FirebaseAuth auth = FirebaseAuth.instance;

  //   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  //   if (googleSignInAccount != null) {
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;

  //     AuthCredential credential = GoogleAuthProvider.getCredential(
  //       idToken: googleSignInAuthentication.idToken,
  //       accessToken: googleSignInAuthentication.accessToken,
  //     );

  //     UserCredential userCredential =
  //         await auth.signInWithCredential(credential);

  //     User user = auth.currentUser;
  //     print(user.uid);

  //     return Future.value(true);
  //   }
  // }

  // Future<void> _handleSignIn() async {
  //   GoogleSignIn _googleSignIn = GoogleSignIn();
  //   // scopes: [
  //   //   'email',
  //   //   'https://www.googleapis.com/auth/contacts.readonly',
  //   // ],
  //   // );
  //   try {
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     UserCredential user =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                child: Image.asset(
                  'assets/images/login_pic.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Form(
                key: _formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(
                    left: 4,
                    right: 20,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
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
                          height: 20,
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
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: _isLoading
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          right: 20.0,
                          left: 20.0,
                          bottom: 20.0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            child: RaisedButton(
                              color: Theme.of(context).buttonColor,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: _trySubmit,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            // Flexible(
            //   child: Container(
            //     margin: const EdgeInsets.only(
            //       right: 20.0,
            //       left: 20.0,
            //       bottom: 5,
            //     ),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(5),
            //       child: RaisedButton(
            //           onPressed: _googleSignIn,
            //           padding:
            //               EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
            //           color: const Color(0xFF4285F4),
            //           child: Row(
            //             mainAxisSize: MainAxisSize.max,
            //             children: <Widget>[
            //               ClipRRect(
            //                 borderRadius: BorderRadius.circular(5),
            //                 child: Container(
            //                   color: Colors.white,
            //                   child: Image.asset(
            //                     'assets/images/google-icon.png',
            //                     height: 48.0,
            //                   ),
            //                 ),
            //               ),
            //               Container(
            //                 padding: EdgeInsets.only(left: 40.0, right: 10.0),
            //                 child: Text(
            //                   "Sign in with Google",
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 20,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           )),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SignUpScreen.routeName);
              },
              child: Center(
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'SIGN UP',
                          style: TextStyle(
                            color: Theme.of(context).buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
