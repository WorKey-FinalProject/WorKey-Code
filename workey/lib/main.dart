import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:time_machine/time_machine.dart';

import './general/providers/company_groups.dart';
import './general/providers/feed_list.dart';
import './general/providers/global_sizes.dart';
import './general/screens/splash_screen.dart';

import './general/widgets/auth/signin_account_type.dart';
import './personal_account/screens/personal_tabs_screen.dart';

import './general/screens/signup_screen.dart';
import './general/screens/auth_screen.dart';
import './general/providers/auth.dart';

Future<void> main() async {
  // Call these two functions before `runApp()`.
  WidgetsFlutterBinding.ensureInitialized();

  await TimeMachine.initialize({'rootBundle': rootBundle});

  await Firebase.initializeApp();
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
        ChangeNotifierProvider<GlobalSizes>(
          create: (ctx) => GlobalSizes(),
        ),
        ChangeNotifierProvider<FeedList>(
          create: (ctx) => FeedList(),
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
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              //return TabsScreen();
              return SignInAccountType();
            }
            return AuthScreen();
          },
        ),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          PersonalTabsScreen.routeName: (ctx) => PersonalTabsScreen(),
        },
      ),
    );
  }
}
