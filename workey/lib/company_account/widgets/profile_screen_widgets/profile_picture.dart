import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 150,
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
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg'),
            ),
          ),
        ),
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
