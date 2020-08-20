import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Colors.blue,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(90),
        ),
      ),
      child: Center(
        child: Text('Logo'),
      ),
    );
  }
}
