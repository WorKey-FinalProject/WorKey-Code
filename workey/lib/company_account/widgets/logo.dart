import 'package:flutter/material.dart';

import '../../company_account/screens/edit_feeds_screen.dart';

class Logo extends StatelessWidget {
  double constraintsMaxHeight;

  Logo(this.constraintsMaxHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraintsMaxHeight,
      child: Stack(
        children: <Widget>[
          Container(
            height: constraintsMaxHeight * 0.85,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 56,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Center(
              child: Text(
                'Hello!',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Theme.of(context).primaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditFeedsScreen(),
                      ),
                    );
                  },
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue,
                          //size: 35,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('Edit Feeds'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
