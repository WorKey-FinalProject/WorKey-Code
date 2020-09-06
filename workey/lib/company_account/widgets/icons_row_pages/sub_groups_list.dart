import 'package:flutter/material.dart';

class SubGroupsList extends StatefulWidget {
  @override
  _SubGroupsListState createState() => _SubGroupsListState();
}

class _SubGroupsListState extends State<SubGroupsList> {
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
    return Column(
      children: <Widget>[
        Flexible(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subGroups.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
