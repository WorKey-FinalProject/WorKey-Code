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
      String companyLogo,
      BuildContext ctx,
    }) async {
      try {
        await Provider.of<Auth>(context, listen: false).signUpCompanyAccount(
          companyEmail: email,
          password: password,
          owenrFirstName: firstName,
          owenrLastName: lastName,
          companyName: companyName,
          companyLogo: companyLogo,
          location: '',
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

    void _submitAuthFormPersonal(
      String email,
      String password,
      String firstName,
      String lastName,
      BuildContext ctx,
    ) async {
      try {
        await Provider.of<Auth>(context, listen: false).signUpPersonalAccount(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          profilePicture: '',
          phoneNumber: '',
          occupation: '',
          dateOfBirth: '',
          address: '',
          faceRecognitionPicture: '',
          fingerPrint: '',
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
      body: SignUpType(_submitAuthFormCompany, _submitAuthFormPersonal),
    );
  }
}
