import 'package:flutter/material.dart';

import '../widgets/logo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Logo(),
        ),
        //feed widget
      ],
    );
  }
}
