import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../general/widgets/profile_picture.dart';
import '../../general/models/snackbar_result.dart';
import '../../general/models/work_group_model.dart';
import '../../general/providers/company_groups.dart';

class AddEmployeeForm extends StatefulWidget {
  @override
  _AddEmployeeForm createState() => _AddEmployeeForm();
}

class _AddEmployeeForm extends State<AddEmployeeForm> {
  // final workGroupLocationController = GoogleMapController;

  final _workGroupNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File _userImageFile;
  // String _userImage;

  Future<void> _addNewWorkGroup() async {
    final workGroupProvider =
        Provider.of<CompanyGroups>(context, listen: false);

    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();

      WorkGroupModel newWorkGroup = WorkGroupModel(
        dateOfCreation: DateTime.now().toString(),
        workGroupName: _workGroupNameController.text,
        workGroupLogo: '',
      );
      newWorkGroup.setImageFile(_userImageFile);

      var isError = false;
      String message;
      try {
        await workGroupProvider.addToFirebaseAndList(newWorkGroup);
      } on PlatformException catch (err) {
        message = 'An error occurred';
        isError = true;

        if (err.message != null) {
          message = err.message;
        }
      } catch (err) {
        isError = true;
        print(err);
      }

      if (isError == false) {
        message = 'Changes saved successfully';
      }

      Navigator.pop(
        context,
        SnackBarResult(
          message: message,
          isError: isError,
        ),
      );
    }
  }

  void _selectImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  @override
  void dispose() {
    _workGroupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfilePicture(
                onSelectImage: _selectImage,
                size: 150,
                isEditable: true,
                imageUrl: '',
                keepImageFile: _userImageFile,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                child: TextFormField(
                  controller: _workGroupNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a name for the workgroup';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Work Group Name'),
                  onSaved: (value) {
                    _workGroupNameController.text = value;
                  },
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 100,
              //         height: 100,
              //         margin: EdgeInsets.only(top: 8.0, right: 10.0),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //               width: 1, color: Theme.of(context).primaryColor),
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(30),
              //           ),
              //         ),
              //         child: _workGroupLogoController.text.isEmpty
              //             ? Align(
              //                 alignment: Alignment.center,
              //                 child: Text('Enter a URL'))
              //             : FittedBox(
              //                 child:
              //                     Image.network(_workGroupLogoController.text),
              //                 fit: BoxFit.cover,
              //               ),
              //       ),
              //       Expanded(
              //         child: TextFormField(
              //           controller: _workGroupLogoController,
              //           keyboardType: TextInputType.url,
              //           decoration: InputDecoration(labelText: 'Image URL'),
              //           onSaved: (value) {
              //             _workGroupLogoController.text = value;
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await _addNewWorkGroup();
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
