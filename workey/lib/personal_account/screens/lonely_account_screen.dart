import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/personal_account_model.dart';
import 'package:workey/general/providers/auth.dart';

class LonleyAccountScreen extends StatefulWidget {
  @override
  _LonleyAccountScreenState createState() => _LonleyAccountScreenState();
}

class _LonleyAccountScreenState extends State<LonleyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    final personalAccountModel = _auth.getDynamicUser as PersonalAccountModel;

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              'You are not currently a member of any workgroups',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Please send your email address to your employer so he can add you to the workgroup',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Flexible(
            child: Card(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  personalAccountModel.email,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'After joining a workgroup, you will be able to view all the relevant content and make full use of the app',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
