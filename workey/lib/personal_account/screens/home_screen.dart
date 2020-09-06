import 'package:flutter/material.dart';

import '../widgets/face_recognition.dart';
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
                height: constraints.maxHeight * 0.25,
                //child: FaceRecognition(),
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