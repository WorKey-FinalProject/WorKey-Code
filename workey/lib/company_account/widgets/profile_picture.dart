import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  String imageUrl;
  double size;
  bool isEditable;

  ProfilePicture({
    this.imageUrl,
    this.size,
    this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size,
          width: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: Colors.white,
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
              )
            ],
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(96.0),
            child: Image.network(
              imageUrl,
            ),
          ),
        ),
        if (isEditable)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          )
      ],
    );
  }
}
