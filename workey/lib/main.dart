import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import './general/screens/signup_screen.dart';
import './company_account/screens/tabs_screen.dart';
import './general/screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  hexColor(String colorHexCode) {
    String colornew = '0xff' + colorHexCode;
    colornew = colornew.replaceAll('#', '');
    int colorInt = int.parse(colornew);
    return colorInt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primaryColor: Colors.green,
        accentColor: Colors.amber,
        //bottomAppBarColor: Color(hexColor('#27AE60')),
        buttonColor: Colors.amber,
        primaryColor: Color(hexColor('#27AE60')),
        // accentColor: Color(hexColor('#68829e')),
        bottomAppBarColor: Colors.white,
        // buttonColor: Color(hexColor('#a01d26')),
        // cardColor: Color(hexColor('#bcbabe')),
        // backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: TabsScreen(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return TabsScreen();
          }
          return AuthScreen();
        },
      ),
      //initialRoute: '/',
      routes: {
        TabsScreen.nameRoute: (ctx) => TabsScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
      },
    );
  }
}
