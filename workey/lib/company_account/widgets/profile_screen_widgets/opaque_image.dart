import 'package:flutter/material.dart';

class OpaqueImage extends StatelessWidget {
  final imageUrl;

  const OpaqueImage({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.fill,
        ),
        Container(
          color: Colors.white.withOpacity(0.80),
        )
      ],
    );
  }
}
