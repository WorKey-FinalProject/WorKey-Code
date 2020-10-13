import 'package:flutter/material.dart';

import '../../company_account/screens/edit_feeds_screen.dart';

class Logo extends StatelessWidget {
  final double constraintsMaxHeight;

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
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 50,
                  color: Color(0xFF12153D).withOpacity(0.2),
                )
              ],
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
            bottom: -20,
            left: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              maxRadius: 55,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 45,
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    //color: Theme.of(context).buttonColor,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditFeedsScreen(),
                      ),
                    );
                  },
                  iconSize: 40,
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
