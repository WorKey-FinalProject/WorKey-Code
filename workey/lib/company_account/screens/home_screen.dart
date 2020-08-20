import 'package:flutter/material.dart';

import '../widgets/logo.dart';
import '../widgets/feed.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              // height: MediaQuery.of(context).size.height * 0.2,
              height: 125,
              child: Logo(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // height: MediaQuery.of(context).size.height,
              height: 500,
              child: Feed(),
            ),
          ],
        ),
      ),
    );
  }
}
