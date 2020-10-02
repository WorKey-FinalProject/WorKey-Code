import 'package:flutter/material.dart';

class GroupTopView extends StatefulWidget {
  final double constraintsMaxHeight;

  GroupTopView(this.constraintsMaxHeight);

  @override
  _GroupTopViewState createState() => _GroupTopViewState();
}

class _GroupTopViewState extends State<GroupTopView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.constraintsMaxHeight,
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.constraintsMaxHeight - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
