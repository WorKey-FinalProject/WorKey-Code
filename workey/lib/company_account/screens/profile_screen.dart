import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  var imageUrl =
      'https://image.shutterstock.com/image-photo/kiev-ukraine-april-16-2015-260nw-276697244.jpg';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Stack(
                children: <Widget>[
                  Image.network(
                    imageUrl,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ],
    );
  }
}
