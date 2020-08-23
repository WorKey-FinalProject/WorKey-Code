import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var a = MediaQuery.of(context).padding.top;
      return Container(
        child: Text(a.toString()),
      );
    });
  }
}
