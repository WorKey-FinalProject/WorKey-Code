import 'package:flutter/material.dart';

import 'rounded_image.dart';

class MyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: RoundedImage(
              imagePath:
                  'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
              size: Size.fromWidth(120.0),
            ),
          ),
        ],
      ),
    );
  }
}
