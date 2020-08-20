import 'package:flutter/material.dart';
import './company_account/screens/tabs_screen.dart';
import './screens/auth_screen.dart';

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
        primaryColor: Colors.blue,
        accentColor: Colors.amber,
        bottomAppBarColor: Colors.blue,
        buttonColor: Colors.amber,
        // primaryColor: Color(hexColor('#505160')),
        // accentColor: Color(hexColor('#68829e')),
        // bottomAppBarColor: Color(hexColor('#20232a')),
        // buttonColor: Color(hexColor('#a01d26')),
        // cardColor: Color(hexColor('#bcbabe')),
        // backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home:
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(),
      },
    );
  }
}
