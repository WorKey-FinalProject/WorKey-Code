import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../general/providers/company_groups.dart';
import '../../general/models/work_group_model.dart';

class AddWorkGroupScreen extends StatefulWidget {
  @override
  _AddWorkGroupScreenState createState() => _AddWorkGroupScreenState();
}

class _AddWorkGroupScreenState extends State<AddWorkGroupScreen> {
  final _workGroupNameController = TextEditingController();
  // final workGroupLocationController = GoogleMapController;
  final _workGroupLogoController = TextEditingController();

  //WorkGroupModel newWorkGroup;

  void _addNewWorkGroup(WorkGroupModel newWorkGroup, BuildContext ctx) async {
    final workGroupProvider = Provider.of<CompanyGroups>(ctx, listen: false);

    try {
      await workGroupProvider.addToFirebaseAndList(newWorkGroup);
    } on PlatformException catch (err) {
      var message = 'An error occurred';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    }
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Changes saved successfully',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _workGroupNameController.dispose();
    _workGroupLogoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Work Group'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                child: TextFormField(
                  controller: _workGroupNameController,
                  decoration: InputDecoration(labelText: 'Work Group Name'),
                  onSaved: (value) {
                    _workGroupNameController.text = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8.0, right: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: _workGroupLogoController.text.isEmpty
                          ? Align(
                              alignment: Alignment.center,
                              child: Text('Enter a URL'))
                          : FittedBox(
                              child:
                                  Image.network(_workGroupLogoController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _workGroupLogoController,
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(labelText: 'Image URL'),
                        onSaved: (value) {
                          _workGroupLogoController.text = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      final isValid = _formKey.currentState.validate();
                      if (isValid) {
                        _formKey.currentState.save();

                        _addNewWorkGroup(
                          WorkGroupModel(
                            dateOfCreation: DateTime.now().toString(),
                            workGroupName: _workGroupNameController.text,
                            workGroupLogo: _workGroupLogoController.text,
                          ),
                          context,
                        );
                      }
                    },
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Done"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
