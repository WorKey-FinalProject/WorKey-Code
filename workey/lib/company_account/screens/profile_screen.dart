import 'package:flutter/material.dart';
import 'package:workey/company_account/screens/account_status.dart';
import 'package:workey/company_account/screens/general_settings.dart';
import 'package:workey/company_account/screens/payment_settings.dart';

import 'account_status.dart';
import 'payment_settings.dart';
import 'general_settings.dart';
import 'info_screen.dart';
import '../widgets/profile_screen_widgets/profile_info_big_card.dart';
import '../widgets/profile_screen_widgets/my_info.dart';
import '../widgets/group_screen_widgets/opaque_image.dart';

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
            Expanded(
              flex: 4,
              child: Stack(
                children: <Widget>[
                  OpaqueImage(
                    imageUrl:
                        'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Company Name',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          MyInfo(),
                        ],
                      ),
                    ),
                  )
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
                                builder: (context) => GeneralSettings(),
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
                                builder: (context) => PaymentSettings(),
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
                                builder: (context) => AccountStatus(),
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
