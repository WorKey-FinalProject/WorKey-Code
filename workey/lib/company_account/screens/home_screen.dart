import 'package:flutter/material.dart';

import '../widgets/logo.dart';
import '../widgets/feed.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Logo(),
        ),
        Divider(),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          //padding: const EdgeInsets.all(5),
          child: Feed(),
        ),
        RaisedButton.icon(
          icon: Icon(Icons.edit),
          label: Text('Edit'),
          elevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: Theme.of(context).accentColor,
          onPressed: () {},
        ),
      ],
    );
  }
}
