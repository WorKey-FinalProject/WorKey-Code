import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:workey/general/widgets/auth/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    void _submitAuthForm(
      String email,
      String password,
      BuildContext ctx,
    ) async {
      try {
        AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData(
          {
            'email': email,
          },
        );
      } on PlatformException catch (err) {
        var message = 'An error occurred, please check your credentials!';

        if (err.message != null) {
          message = err.message;
        }

        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(ctx).errorColor,
          ),
        );
      } catch (err) {
        print(err);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SignUpForm(_submitAuthForm),
      // body: ListView(
      //   children: <Widget>[
      //     BackButtonWidget(),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Row(
      //         children: <Widget>[
      //           IconButton(
      //             icon: Icon(Icons.mail),
      //             onPressed: () {},
      //           ),
      //           Expanded(
      //             child: Container(
      //               margin: EdgeInsets.only(left: 4, right: 20),
      //               child: TextField(
      //                 decoration: InputDecoration(hintText: 'Email'),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Row(
      //         children: <Widget>[
      //           IconButton(
      //             icon: Icon(Icons.lock),
      //             onPressed: () {},
      //           ),
      //           Expanded(
      //             child: Container(
      //               margin: EdgeInsets.only(left: 4, right: 20),
      //               child: TextField(
      //                 decoration: InputDecoration(hintText: 'Password'),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Row(
      //         children: <Widget>[
      //           IconButton(
      //             icon: Icon(Icons.lock),
      //             onPressed: () {},
      //           ),
      //           Expanded(
      //             child: Container(
      //               margin: EdgeInsets.only(left: 4, right: 20),
      //               child: TextField(
      //                 decoration: InputDecoration(hintText: 'Password'),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         children: <Widget>[
      //           Radio(value: null, groupValue: null, onChanged: null),
      //           RichText(
      //             text: TextSpan(
      //               text: 'I have accepted the',
      //               style: TextStyle(color: Colors.black),
      //               children: [
      //                 TextSpan(
      //                   text: 'Terms & Condition',
      //                   style: TextStyle(
      //                     color: Colors.teal,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(5),
      //         child: Container(
      //           height: 60,
      //           child: RaisedButton(
      //             color: Theme.of(context).buttonColor,
      //             child: Text(
      //               'SIGN UP',
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 20),
      //             ),
      //             onPressed: () {},
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
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
