import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:workey/general/widgets/auth/signup_type.dart';
import '../providers/auth.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    void _submitAuthFormCompany({
      String email,
      String password,
      String firstName,
      String lastName,
      String companyName,
      File imageFile,
      BuildContext ctx,
    }) async {
      try {
        await Provider.of<Auth>(context, listen: false).signUpCompanyAccount(
          companyEmail: email,
          password: password,
          owenrFirstName: firstName,
          owenrLastName: lastName,
          companyName: companyName,
          companyLogo: '',
          imageFile: imageFile,
        );
      } on PlatformException catch (err) {
        var message = 'An error occurred, please check your credentials!';

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
      Navigator.of(context).pop();
    }

    void _submitAuthFormPersonal({
      String email,
      String password,
      String firstName,
      String lastName,
      String phoneNumber = '',
      String dateOfBirth = '',
      String address = '',
      File imageFile,
      BuildContext ctx,
    }) async {
      try {
        await Provider.of<Auth>(context, listen: false).signUpPersonalAccount(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          profilePicture: '',
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
          address: address,
          faceRecognitionPicture: '',
          fingerPrint: '',
          imageFile: imageFile,
        );
      } on PlatformException catch (err) {
        var message = 'An error occurred, please check your credentials!';

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
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SignUpType(_submitAuthFormCompany, _submitAuthFormPersonal)),
    );
  }
}
