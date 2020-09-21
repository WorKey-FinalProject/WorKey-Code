import 'package:flutter/material.dart';

class LoadingCircleOnScreen extends StatelessWidget {
  final BuildContext ctx;

  LoadingCircleOnScreen(this.ctx);

  @override
  Widget build(BuildContext context) {
    return buildShowDialog(ctx);
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
