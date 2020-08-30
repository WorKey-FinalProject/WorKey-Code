import 'package:flutter/material.dart';

import '../widgets/logo.dart';
import '../widgets/feed.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return //SingleChildScrollView(
        LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.25,
                child: Logo(),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.7,
                child: Feed(),
              ),
            ],
          ),
        );
      },
    );
  }
}
