import 'package:flutter/material.dart';

import '../switch_item.dart';

class GeneralSettingsScreen extends StatefulWidget {
  @override
  _GeneralSettingsScreenState createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
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
                  ),
                ),
              ),
            ],
          ),
          _rowBuild('Feed'),
          _rowBuild('Mail'),
          _rowBuild('Employee Enter'),
          _rowBuild('Employee Exit'),
        ],
      ),
    );
  }

  var switchHandler;
  var switchHandlerFeed = false;
  var switchHandlerMail = false;
  var switchHandlerEmployeeEnter = false;
  var switchHandlerEmployeeExit = false;

  _toggleFeed() {
    setState(() {
      switchHandlerFeed = !switchHandlerFeed;
    });
  }

  _toggleMail() {
    setState(() {
      switchHandlerMail = !switchHandlerMail;
    });
  }

  _toggleEmployeeEnter() {
    setState(() {
      switchHandlerEmployeeEnter = !switchHandlerEmployeeEnter;
    });
  }

  _toggleEmployeeExit() {
    setState(() {
      switchHandlerEmployeeExit = !switchHandlerEmployeeExit;
    });
  }

  Function _toggleSelector(String selector) {
    if (selector == "Feed") {
      return _toggleFeed;
    } else if (selector == "Mail") {
      return _toggleMail;
    } else if (selector == "Employee Enter") {
      return _toggleEmployeeEnter;
    } else if (selector == "Employee Exit") {
      return _toggleEmployeeExit;
    } else {
      return null;
    }
  }

  bool _checkedSelector(String selector) {
    if (selector == "Feed") {
      switchHandler = switchHandlerFeed;
      return switchHandler;
    } else if (selector == "Mail") {
      switchHandler = switchHandlerMail;
      return switchHandler;
    } else if (selector == "Employee Enter") {
      switchHandler = switchHandlerEmployeeEnter;
      return switchHandler;
    } else if (selector == "Employee Exit") {
      switchHandler = switchHandlerEmployeeExit;
      return switchHandler;
    } else {
      return null;
    }
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
            onTap: _toggleSelector(title),
            behavior: HitTestBehavior.translucent,
            child: SwitchItem(
              checked: _checkedSelector(title),
            ),
          ),
        ],
      ),
    );
  }
}
