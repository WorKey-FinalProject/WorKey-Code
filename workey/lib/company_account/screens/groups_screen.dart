import 'package:flutter/material.dart';

import '../widgets/icons_row.dart';

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
                    width: double.infinity,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'LOGO',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: constraints.maxHeight / 5,
                width: MediaQuery.of(context).size.width,
                child: IconsRow(),
              ),
              Divider(
                thickness: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
