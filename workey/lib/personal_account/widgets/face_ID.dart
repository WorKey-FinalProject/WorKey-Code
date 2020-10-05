import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FaceID extends StatelessWidget {
  final double constraintsMaxHeight;

  FaceID(this.constraintsMaxHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraintsMaxHeight,
      child: Stack(
        children: <Widget>[
          Container(
            height: constraintsMaxHeight * 0.75,
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
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Theme.of(context).primaryColor.withOpacity(0.23),
                ),
              ],
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
            bottom: -10,
            left: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              maxRadius: 60,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 50,
                child: IconButton(
                  icon: Icon(MdiIcons.faceRecognition),
                  onPressed: () {
                    print('Enter shift - Face recognition button');
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
