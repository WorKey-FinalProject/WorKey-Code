import 'package:flutter/material.dart';

class AccountStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Status'),
        elevation: 0,
      ),
      body: Center(
        child: Text('status'),
      ),
    );
  }
}
