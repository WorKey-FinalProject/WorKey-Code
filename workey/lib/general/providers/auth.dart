import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../general/models/work_group_model.dart';
import '../../general/widgets/auth/signup_type.dart';
import '../models/company_account_model.dart';
import '../models/personal_account_model.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference();

  AccountTypeChosen accountType;
  User user;

  CompanyAccountModel companyAccountModel = CompanyAccountModel(
    companyEmail: null,
    companyName: null,
    owenrFirstName: null,
    owenrLastName: null,
    dateOfCreation: null,
  );

  PersonalAccountModel personalAccountModel = PersonalAccountModel(
    email: null,
    dateOfCreation: null,
    firstName: null,
    lastName: null,
  );

  Future<void> signUpPersonalAccount({
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String dateOfBirth,
    String address,
    String occupation,
    String faceRecognitionPicture,
    String fingerPrint,
    String profilePicture,
  }) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      personalAccountModel = PersonalAccountModel(
        id: authResult.user.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        address: address,
        occupation: occupation,
        faceRecognitionPicture: faceRecognitionPicture,
        profilePicture: profilePicture,
        fingerPrint: fingerPrint,
        dateOfCreation: DateTime.now().toString(),
      );
      await dbRef
          .child('Users')
          .child('Personal Accounts')
          .child(authResult.user.uid)
          .set(personalAccountModel.toJson());
    } on Exception catch (error) {
      print(error);
    }
  }

  Future<void> signUpCompanyAccount({
    String companyEmail,
    String password,
    String companyName,
    String location,
    String companyLogo,
    String owenrFirstName,
    String owenrLastName,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: companyEmail,
        password: password,
      );
      user = userCredential.user;
      if (companyLogo != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('company_account_logo')
            .child(user.uid + '.jpg');

        await ref.putFile(File(companyLogo)).onComplete;

        final url = await ref.getDownloadURL();
        companyLogo = url;
      }

      companyAccountModel = CompanyAccountModel(
        id: userCredential.user.uid,
        companyEmail: companyEmail,
        companyName: companyName,
        owenrFirstName: owenrFirstName,
        owenrLastName: owenrLastName,
        dateOfCreation: DateTime.now().toString(),
        companyLogo: companyLogo.toString(),
        location: location,
      );

      WorkGroupModel workGroupModel = WorkGroupModel(
        workGroupName: 'Root',
        managerId: null,
        parentWorkGroupId: null,
        dateOfCreation: null,
        workGroupLogo: null,
      );
      await dbRef
          .child('Users')
          .child('Company Accounts')
          .child(userCredential.user.uid)
          .set(companyAccountModel.toJson());
      await dbRef
          .child('Company Groups')
          .child(userCredential.user.uid)
          .set(workGroupModel.toJson());
    } on Exception catch (error) {
      print(error);
    }
  }

  Future<void> signin(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (authResult) {
        user = authResult.user;
      },
    );
  }

  Future<AccountTypeChosen> findCurrAccountType(User user) async {
    this.user = user;
    await dbRef.child('Users').once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> map = dataSnapshot.value;
      map.forEach((key, value) {
        Map<dynamic, dynamic> map2 = value;
        var list = map2.keys.toList();
        list.forEach((id) {
          if (id == user.uid) {
            if (key == 'Personal Accounts') {
              accountType = AccountTypeChosen.personal;
            } else if (key == 'Company Accounts') {
              accountType = AccountTypeChosen.company;
            }
          }
        });
      });
    });
    return accountType;
  }

  Future<dynamic> getCurrUserData() async {
    dynamic dynamicUser;
    try {
      if (accountType == AccountTypeChosen.company) {
        dynamicUser = companyAccountModel;
        await dbRef
            .child('Users')
            .child('Company Accounts')
            .child(user.uid)
            .once()
            .then((DataSnapshot dataSnapshot) {
          dynamicUser.fromJsonToObject(dataSnapshot.value, user.uid);
          dynamicUser.id = user.uid;
        });
      } else if (accountType == AccountTypeChosen.personal) {
        dynamicUser = personalAccountModel;
        await dbRef
            .child('Users')
            .child('Personal Accounts')
            .child(user.uid)
            .once()
            .then((DataSnapshot dataSnapshot) {
          dynamicUser.fromJsonToObject(dataSnapshot.value, user.uid);
          dynamicUser.id = user.uid;
        });
      } else {
        throw 'failed to get user data: error - accountType == nothing.';
      }
    } on Exception {
      throw ErrorHint;
    }
    return dynamicUser;
  }

  Future<void> updateCurrUserPassword(String newPassword) async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      await user.updatePassword(newPassword);
    } catch (error) {
      throw error;
    }
    print('Password updated Successfully');
  }

  Future<void> updateCurrUserData(dynamic userNewData) async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      String type;
      if (accountType == AccountTypeChosen.company) {
        type = 'Company Accounts';
        if (userNewData.companyLogo != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('company_account_logo')
              .child(user.uid + '.jpg');
          await ref.putFile(File(userNewData.companyLogo)).onComplete;
          print('File Uploaded');
          final url = await ref.getDownloadURL();
          userNewData.companyLogo = url;
        }

        await user.updateEmail(userNewData.companyEmail);
      } else if (accountType == AccountTypeChosen.personal) {
        type = 'Personal Accounts';
        user.updateEmail(userNewData.email);
      } else {
        print("problem with updateCurrUserData");
        return null;
      }
      await dbRef
          .child('Users')
          .child(type)
          .child(user.uid)
          .update(userNewData.toJson());
    } on Exception catch (error) {
      throw error;
    }
  }

  Future<void> deleteCurrUserData() async {
    try {
      String type;
      if (accountType == AccountTypeChosen.company) {
        type = 'Company Accounts';
      } else {
        type = 'Personal Accounts';
      }

      await dbRef.child('Users').child(type).child(user.uid).remove();
      User firebaseUser = FirebaseAuth.instance.currentUser;

      firebaseUser.delete();
    } on Exception {
      throw ErrorHint;
    }
  }
}
