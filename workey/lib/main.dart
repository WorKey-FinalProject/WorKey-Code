import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/providers/feed_list.dart';
import 'package:workey/general/providers/global_sizes.dart';

import 'package:workey/general/providers/monthly_shift_summery_list.dart';

import 'package:workey/general/providers/mail_provider.dart';

import 'package:workey/general/providers/shifts.dart';
import 'package:workey/general/screens/splash_screen.dart';

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

// void printHello() {
//   final DateTime now = DateTime.now();
//   print("[$now] Hello, world!");
// }

Future<void> main() async {
  // Call these two functions before `runApp()`.
  WidgetsFlutterBinding.ensureInitialized();
  await TimeMachine.initialize({'rootBundle': rootBundle});
  await Firebase.initializeApp();
  // await AndroidAlarmManager.initialize();
  runApp(MyApp());
  // await AndroidAlarmManager.oneShot(const Duration(seconds: 7), 0, printHello);
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
        ChangeNotifierProvider<Shifts>(
          create: (ctx) => Shifts(),
        ),
        ChangeNotifierProvider<MonthltShiftSummeryList>(
          create: (ctx) => MonthltShiftSummeryList(),
        ),
        ChangeNotifierProvider<MailProvider>(
          create: (ctx) => MailProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Workey',
        theme: ThemeData(
          primaryColor: Colors.blue[600],
          accentColor: Colors.blue[100],
          buttonColor: Colors.brown[300],
          secondaryHeaderColor: Colors.brown[200],

          // primaryColor: Color(hexColor('#27AE60')),
          //primaryColor: Colors.blue,
          // accentColor: Colors.amber,
          // buttonColor: Colors.amber,
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
