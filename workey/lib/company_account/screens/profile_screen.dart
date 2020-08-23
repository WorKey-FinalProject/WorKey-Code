import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight / 2,
                color: Colors.black,
              ),
              Container(
                color: Colors.blue,
                height: constraints.maxHeight / 2,
              ),
            ],
          ),
        );
      },
    );
    // return Container(
    //   constraints: BoxConstraints.tightFor(height: context.size.height),
    //   child: Column(children: <Widget>[
    //     Container(
    //       constraints: BoxConstraints.expand(),
    //       color: Colors.blue,
    //     ),
    //     Container(
    //       constraints: BoxConstraints.expand(),
    //       color: Colors.black,
    //     ),
    //   ]),
    // );
  }
}
