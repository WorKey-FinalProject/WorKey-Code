import 'package:flutter/material.dart';

class ProfileInfoBigCard extends StatelessWidget {
  final String text;
  final Widget icon;

  const ProfileInfoBigCard({
    Key key,
    @required this.text,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      // height: 150,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 16,
            bottom: 24,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: icon,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
