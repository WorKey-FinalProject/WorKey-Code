import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/company_account_model.dart';

import '../../general/providers/auth.dart';
import '../screens/profile_screens/general_settings_screen.dart';
import '../screens/profile_screens/payment_info_screen.dart';
import 'profile_screens/personal_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var imageUrl =
      'https://image.shutterstock.com/image-photo/kiev-ukraine-april-16-2015-260nw-276697244.jpg';

  CompanyAccountModel userData;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Theme.of(context).accentColor,
              indicatorColor: Theme.of(context).accentColor,
              tabs: [
                Tab(icon: Icon(Icons.person_outline)),
                Tab(icon: Icon(Icons.payment)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PersonalInfoScreen(_auth),
            PaymentInfoScreen(),
            GeneralSettingsScreen(),
          ],
        ),
      ),
    );

    // return Stack(
    //   children: <Widget>[
    //     Column(
    //       children: <Widget>[
    //         Flexible(
    //           flex: 4,
    //           fit: FlexFit.tight,
    //           child: Stack(
    //             children: <Widget>[
    //               // OpaqueImage(
    //               //   imageUrl:
    //               //       'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
    //               // ),

    //               Container(
    //                 height: double.infinity,
    //                 width: double.infinity,
    //                 padding: EdgeInsets.only(
    //                   left: 30,
    //                   right: 30,
    //                   bottom: 10,
    //                   top: 30,
    //                 ),
    //                 margin: EdgeInsets.only(top: 60),
    //                 child: Card(
    //                   color: Colors.white,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(66),
    //                   ),
    //                   elevation: 10,
    //                   child: Container(
    //                     padding: EdgeInsets.symmetric(
    //                       horizontal: 10,
    //                       vertical: 20,
    //                     ),
    //                     alignment: Alignment.bottomCenter,
    //                     child: Text(
    //                       'Company Name',
    //                       style: TextStyle(
    //                         fontSize: 22,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 left: 0,
    //                 right: 0,
    //                 child: Container(
    //                   alignment: Alignment.center,
    //                   padding: const EdgeInsets.all(16),
    //                   child: ProfilePicture(),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           flex: 5,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Flexible(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Flexible(
    //                       fit: FlexFit.tight,
    //                       child: GestureDetector(
    //                         onTap: () => Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => PersonalInfoScreen(),
    //                           ),
    //                         ),
    //                         child: Padding(
    //                           padding:
    //                               const EdgeInsets.only(left: 8.0, top: 8.0),
    //                           child: ProfileInfoBigCard(
    //                             text: 'Personal Info',
    //                             icon: Icon(
    //                               Icons.person,
    //                               color: Theme.of(context).primaryColor,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Flexible(
    //                       fit: FlexFit.tight,
    //                       child: GestureDetector(
    //                         onTap: () => Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => GeneralSettingsScreen(),
    //                           ),
    //                         ),
    //                         child: Padding(
    //                           padding:
    //                               const EdgeInsets.only(right: 8.0, top: 8.0),
    //                           child: ProfileInfoBigCard(
    //                             text: 'General Settings',
    //                             icon: Icon(
    //                               Icons.settings,
    //                               color: Theme.of(context).primaryColor,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Flexible(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Flexible(
    //                       fit: FlexFit.tight,
    //                       child: GestureDetector(
    //                         onTap: () => Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => PaymentSettingsScreen(),
    //                           ),
    //                         ),
    //                         child: Padding(
    //                           padding:
    //                               const EdgeInsets.only(left: 8.0, bottom: 8.0),
    //                           child: ProfileInfoBigCard(
    //                             text: 'Payment Settings',
    //                             icon: Icon(
    //                               Icons.payment,
    //                               color: Theme.of(context).primaryColor,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Flexible(
    //                       fit: FlexFit.tight,
    //                       child: GestureDetector(
    //                         onTap: () => Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => AccountStatusScreen(),
    //                           ),
    //                         ),
    //                         child: Padding(
    //                           padding: const EdgeInsets.only(
    //                               right: 8.0, bottom: 8.0),
    //                           child: ProfileInfoBigCard(
    //                             text: 'Account Status',
    //                             icon: Icon(
    //                               Icons.info,
    //                               color: Theme.of(context).primaryColor,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
