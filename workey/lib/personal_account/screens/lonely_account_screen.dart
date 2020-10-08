import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/personal_account_model.dart';
import 'package:workey/general/providers/auth.dart';

class LonleyAccountScreen extends StatefulWidget {
  @override
  _LonleyAccountScreenState createState() => _LonleyAccountScreenState();
}

class _LonleyAccountScreenState extends State<LonleyAccountScreen> {
  var _isLoading = false;
  PersonalAccountModel personalAccountModel;

  void _refresh(Auth auth) async {
    setState(() {
      _isLoading = true;
    });
    personalAccountModel = await auth.getCurrUserData() as PersonalAccountModel;
    print(personalAccountModel.companyId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);
    personalAccountModel = _auth.getDynamicUser as PersonalAccountModel;

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
          Expanded(
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
          Expanded(
            child: Card(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          personalAccountModel.email,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: personalAccountModel.email),
                          ).then((result) {
                            // show toast or snackbar after successfully save
                            Fluttertoast.showToast(msg: "copied");
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
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
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  )
                : IconButton(
                    onPressed: () => _refresh(_auth),
                    icon: Icon(Icons.refresh),
                    iconSize: 50,
                  ),
          )
        ],
      ),
    );
  }
}
