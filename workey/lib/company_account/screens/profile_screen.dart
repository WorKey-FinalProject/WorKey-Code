import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.black,
            width: double.infinity,
            height: 10,
          ),
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: 10,
            //constraints: BoxConstraints(maxHeight: context.size.height * 0.5),
          ),
        ],
      ),
    );
  }
}
