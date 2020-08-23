import 'package:flutter/material.dart';

class FeedItem extends StatelessWidget {
  final String title;
  final String text;

  FeedItem({
    @required this.title,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20),
      // color: Theme.of(context).cardColor,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40),
            ),
            Divider(),
            FittedBox(
              child: Text(
                text,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
