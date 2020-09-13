import 'package:flutter/material.dart';

import 'profile_screens/account_status_screen.dart';
import 'profile_screens/general_settings_screen.dart';
import 'profile_screens/payment_screen.dart';
import 'profile_screens/account_status_screen.dart';
import 'profile_screens/payment_screen.dart';
import 'profile_screens/general_settings_screen.dart';
import 'profile_screens/info_screen.dart';
import '../widgets/profile_screen_widgets/profile_info_big_card.dart';
import '../widgets/profile_screen_widgets/profile_picture.dart';
import '../widgets/profile_screen_widgets/opaque_image.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var imageUrl =
      'https://image.shutterstock.com/image-photo/kiev-ukraine-april-16-2015-260nw-276697244.jpg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Stack(
                children: <Widget>[
                  // OpaqueImage(
                  //   imageUrl:
                  //       'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                  // ),

                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      bottom: 10,
                      top: 30,
                    ),
                    margin: EdgeInsets.only(top: 60),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(66),
                      ),
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Company Name',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: ProfilePicture(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoScreen(),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: ProfileInfoBigCard(
                                text: 'Personal Info',
                                icon: Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GeneralSettingsScreen(),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
                              child: ProfileInfoBigCard(
                                text: 'General Settings',
                                icon: Icon(
                                  Icons.settings,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentSettingsScreen(),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8.0),
                              child: ProfileInfoBigCard(
                                text: 'Payment Settings',
                                icon: Icon(
                                  Icons.payment,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountStatusScreen(),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 8.0),
                              child: ProfileInfoBigCard(
                                text: 'Account Status',
                                icon: Icon(
                                  Icons.info,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
