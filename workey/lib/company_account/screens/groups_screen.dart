import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  bool _pathHandler;

  @override
  void initState() {
    _pathHandler = false;
    super.initState();
  }

  _pathIsChanged() {
    setState(() {
      _pathHandler = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_pathHandler);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: GestureDetector(
                  onTap: () {
                    _pathIsChanged();
                    print(_pathHandler);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    height: constraints.maxHeight / 4,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Card(
                      elevation: 6,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('LOGO'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: constraints.maxHeight / 5,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.people), onPressed: null),
                    IconButton(icon: Icon(Icons.place), onPressed: null),
                    IconButton(icon: Icon(MdiIcons.sword), onPressed: null),
                    // IconButton(icon: Icon(Icons.), onPressed: null),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}
