import 'package:flutter/material.dart';

import '../widgets/add_workgroup_form.dart';

class AddWorkGroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Work Group'),
      ),
      body: AddWorkGroupForm(),
    );
  }
}
