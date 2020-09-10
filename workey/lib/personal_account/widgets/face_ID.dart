import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FaceID extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 20,
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

            // child: Center(
            //   child:
            //       IconButton(icon: Icon(MdiIcons.faceRecognition), onPressed: null),
            //   // child: GestureDetector(
            //   //   onTap: () => null,
            //   //   child: Icon(
            //   //     MdiIcons.faceRecognition,
            //   //     color: Colors.white,
            //   //     size: 70,
            //   //   ),
            //   // ),Icon
            // ),
          ),
          Positioned(
            left: 150,
            right: 150,
            bottom: -40,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              maxRadius: 60,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 50,
                child: IconButton(
                  icon: Icon(MdiIcons.faceRecognition),
                  onPressed: null,
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
