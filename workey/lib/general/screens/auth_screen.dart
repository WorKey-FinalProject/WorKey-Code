import 'package:flutter/material.dart';
import 'package:workey/general/widgets/auth/auth_form.dart';

import './signup_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthForm(),

      // body: ListView(
      //   children: <Widget>[
      //     Container(
      //       height: 300,
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           image: NetworkImage(
      //             'https://theservicefort.com/wp-content/uploads/2016/12/fortservices-clean-workspaces1.jpg',
      //           ),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
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
      //     SizedBox(
      //       height: 20,
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
      //               'SIGN IN',
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
      //     SizedBox(
      //       height: 20,
      //     ),
      //     InkWell(
      //       onTap: () {
      //         Navigator.of(context).pushNamed(SignUpScreen.routeName);
      //       },
      //       child: Center(
      //         child: RichText(
      //           text: TextSpan(
      //               text: 'Don\'t have an account? ',
      //               style: TextStyle(color: Colors.black),
      //               children: <TextSpan>[
      //                 TextSpan(
      //                   text: 'SIGN UP',
      //                   style: TextStyle(
      //                     color: Theme.of(context).buttonColor,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 )
      //               ]),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
