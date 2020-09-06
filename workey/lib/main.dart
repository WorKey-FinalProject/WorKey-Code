import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/screens/splash_screen.dart';

import './general/screens/signup_screen.dart';
import './company_account/screens/tabs_screen.dart';
import './general/screens/auth_screen.dart';
import './general/providers/auth.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider<CompanyGroups>(
          create: (ctx) => CompanyGroups(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //primaryColor: Color(hexColor('#27AE60')),
          primaryColor: Color(hexColor('#27AE60')),
          //primaryColor: Colors.blue,
          accentColor: Colors.amber,
          // accentColor: Color(hexColor('#68829e')),
          buttonColor: Colors.amber,
          // buttonColor: Color(hexColor('#a01d26')),
          bottomAppBarColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: TabsScreen(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              return TabsScreen();
            }
            return AuthScreen();
          },
        ),
        routes: {
          TabsScreen.nameRoute: (ctx) => TabsScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
        },
      ),
    );
  }
}
