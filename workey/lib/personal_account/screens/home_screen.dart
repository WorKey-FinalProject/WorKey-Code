import 'package:flutter/material.dart';

import '../widgets/face_ID.dart';
import '../../general/widgets/feed.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: FaceID(constraints.maxHeight * 0.25),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.7,
                child: Feed(),
              ),
            ],
          ),
        );
      },
    );
  }
}
