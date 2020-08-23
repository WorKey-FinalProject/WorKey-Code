import 'package:flutter/material.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  var _pathHandler = false;

  _pathIsChanged() {
    setState(() {
      _pathHandler = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_pathHandler
          ? null
          : AppBar(
              bottom: PreferredSize(
                child: Text('bottom'),
                preferredSize: Size.fromHeight(10),
              ),
            ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _pathIsChanged();
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
                Container(
                  height: constraints.maxHeight / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        minRadius: 40,
                        child: Text('1'),
                      ),
                      CircleAvatar(
                        minRadius: 40,
                        child: Text('2'),
                      ),
                      CircleAvatar(
                        minRadius: 40,
                        child: Text('3'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
