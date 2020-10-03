import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../general/providers/auth.dart';
import '../../personal_account/widgets/profile_form.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      body: ProfileForm(_auth),
    );
  }
}
