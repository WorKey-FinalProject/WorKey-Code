import 'package:flutter/material.dart';

import '../switch_item.dart';

class GeneralSettingsScreen extends StatefulWidget {
  @override
  _GeneralSettingsScreenState createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  var switchHandler = false;

  void _toggle() {
    setState(() {
      switchHandler = !switchHandler;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              Text("Notifications"),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ],
          ),
          _rowBuild('Feed'),
          _rowBuild('Mail'),
          _rowBuild('Employye Enter'),
          _rowBuild('Employee Exit'),
        ],
      ),
    );
  }

  Widget _rowBuild(
    String title,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('$title'),
          GestureDetector(
            onTap: _toggle,
            behavior: HitTestBehavior.translucent,
            child: SwitchItem(
              checked: switchHandler,
            ),
          ),
        ],
      ),
    );
  }
}
