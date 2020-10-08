import 'package:flutter/material.dart';
import 'package:workey/personal_account/widgets/icons_grid_view.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text("Group\'s Info"),
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
        Text('data'),
        Text('data'),
        Text('data'),
        Text('data'),
        Text('data'),
        Text('data'),
        Text('data'),
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
            Text("Icons"),
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
        Expanded(
          child: IconsGridView(),
        ),
      ],
    );
  }
}
