import 'package:flutter/material.dart';

class GeneralSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Settings'),
        elevation: 0,
      ),
      body: Center(
        child: Text('settings'),
      ),
    );
  }
}
