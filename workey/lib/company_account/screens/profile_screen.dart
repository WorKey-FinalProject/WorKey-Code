import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            color: Colors.black,
          ),
        ),
        Flexible(fit: FlexFit.tight, child: Container(color: Colors.blue)),
      ],
    );
  }
}
