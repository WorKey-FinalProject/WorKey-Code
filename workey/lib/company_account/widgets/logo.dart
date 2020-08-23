import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
            blurRadius: 6,
          )
        ],
      ),
      child: Center(
        child: Text('Logo'),
      ),
    );
  }
}
