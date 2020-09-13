import 'package:flutter/material.dart';

class PaymentSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Settings'),
        elevation: 0,
      ),
      body: Center(
        child: Text('payment'),
      ),
    );
  }
}
