import 'package:flutter/material.dart';

class SubGroupsList extends StatefulWidget {
  var isShrink;

  SubGroupsList(this.isShrink);

  @override
  _SubGroupsListState createState() => _SubGroupsListState();
}

class _SubGroupsListState extends State<SubGroupsList> {
  double heightForMargin = 0;
  List<String> subGroups = [
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third',
    'first',
    'second',
    'third'
  ];

  @override
  Widget build(BuildContext context) {
    print(widget.isShrink);
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.maxHeight);
        return Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: ListView.builder(
                scrollDirection:
                    widget.isShrink ? Axis.vertical : Axis.horizontal,
                itemCount: subGroups.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    height: 200,
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Container(
                        child: widget.isShrink
                            ? Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey,
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
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      subGroups[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey,
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
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      subGroups[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 5,
              ),
              child: RaisedButton(
                onPressed: () {},
                color: Theme.of(context).accentColor,
                child: Text(
                  'Add new work group',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
