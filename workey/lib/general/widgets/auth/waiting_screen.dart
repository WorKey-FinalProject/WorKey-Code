import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  Function func;

  WaitingScreen(this.func);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  void initState() {
    widget.func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
