import 'package:flutter/material.dart';

import '../widgets/profile_screen_widgets/profile_info_big_card.dart';
import '../widgets/profile_screen_widgets/my_info.dart';
import '../widgets/profile_screen_widgets/opaque_image.dart';

class ProfileScreen extends StatelessWidget {
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
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: ProfileInfoBigCard(
                              text: 'Personal Info',
                              icon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Flexible(
                            child: ProfileInfoBigCard(
                              text: 'General Settings',
                              icon: Icon(
                                Icons.settings,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: ProfileInfoBigCard(
                              text: 'Payment Settings',
                              icon: Icon(
                                Icons.payment,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Flexible(
                            child: ProfileInfoBigCard(
                              text: 'Account Status',
                              icon: Icon(
                                Icons.info,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
