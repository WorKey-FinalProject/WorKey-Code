import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../general/models/company_group_model.dart';

import '../../general/widgets/auth/signup_type.dart';
import '../models/company_account_model.dart';
import '../models/personal_account_model.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference();
  final _fcm = FirebaseMessaging();

  AccountTypeChosen accountType;
  User user;

  String companyAccountImagePath = 'company_account_logo';
  String personalAccountImagePath = 'personal_account_pic';

  dynamic _dynamicUser;

  CompanyAccountModel companyAccountModel = CompanyAccountModel(
    companyEmail: null,
    companyName: null,
    owenrFirstName: null,
    owenrLastName: null,
    dateOfCreation: null,
    //token: '',
  );

  PersonalAccountModel personalAccountModel = PersonalAccountModel(
    email: null,
    dateOfCreation: null,
    firstName: null,
    lastName: null,
    //token: '',
  );

  get getAccountTypeChosen {
    return accountType;
  }

  get getDynamicUser {
    return _dynamicUser;
  }

  /// signUpPersonalAccount
  Future<void> signUpPersonalAccount({
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String dateOfBirth,
    String address,
    String faceRecognitionPicture,
    String fingerPrint,
    String profilePicture,
    File imageFile,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ///Profile Pic Upload
      if (imageFile != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child(companyAccountImagePath)
            .child(userCredential.user.uid + '.jpg');
        await ref
            .putFile(
              imageFile,
            )
            .onComplete;
        print('File Uploaded');

        final url = await ref.getDownloadURL();
        profilePicture = url;
      }

      personalAccountModel = PersonalAccountModel(
        id: userCredential.user.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        address: address,
        faceRecognitionPicture: faceRecognitionPicture,
        profilePicture: profilePicture,
        fingerPrint: fingerPrint,
        dateOfCreation: DateTime.now().toString(),
        companyId: '',
        //token: '',
      );
      await dbRef
          .child('Users')
          .child('Personal Accounts')
          .child(userCredential.user.uid)
          .set(personalAccountModel.toJson());
    } on Exception catch (error) {
      print(error);
    }
  }

  /// signUpCompanyAccount
  Future<void> signUpCompanyAccount({
    String companyEmail,
    String password,
    String companyName,
    String location,
    String companyLogo,
    String owenrFirstName,
    String owenrLastName,
    File imageFile,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: companyEmail,
        password: password,
      );

      ///Profile Pic Upload
      if (imageFile != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child(companyAccountImagePath)
            .child(userCredential.user.uid + '.jpg');
        await ref
            .putFile(
              imageFile,
            )
            .onComplete;
        print('File Uploaded');

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
        companyLogo: companyLogo,
        //token: '',
      );

      CompanyGroupModel companyGroupModel = CompanyGroupModel(
        id: userCredential.user.uid,
        employeeList: '',
        feedList: '',
        workGroupList: '',
        shiftList: '',
      );
      await dbRef
          .child('Users')
          .child('Company Accounts')
          .child(userCredential.user.uid)
          .set(companyAccountModel.toJson());
      await dbRef
          .child('Company Groups')
          .child(userCredential.user.uid)
          .set(companyGroupModel.toJson());
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
      (authResult) async {
        user = authResult.user;
        //await _saveDeviceToken();
      },
    );
  }

  /// findCurrAccountType
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

  /// getCurrUserData
  Future<dynamic> getCurrUserData() async {
    print(accountType);
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
    _dynamicUser = dynamicUser;
    notifyListeners();
    return dynamicUser;
  }

  /// updateCurrUserPassword
  Future<void> updateCurrUserPassword(
      String oldPassword, String newPassword) async {
    try {
      AuthCredential authCredential = EmailAuthProvider.credential(
          email: user.email, password: oldPassword);
      await user
          .reauthenticateWithCredential(authCredential)
          .then((result) async {
        await user.updatePassword(newPassword);
        print(result);
      }).catchError((error) {
        print(error);
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateCurrUserData(dynamic userNewData) async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      String type;
      String imagePathFolder;
      if (accountType == AccountTypeChosen.company) {
        type = 'Company Accounts';

        imagePathFolder = companyAccountImagePath;
        await user.updateEmail(userNewData.companyEmail);
      } else if (accountType == AccountTypeChosen.personal) {
        type = 'Personal Accounts';

        imagePathFolder = personalAccountImagePath;
        await user.updateEmail(userNewData.email);
      } else {
        print("problem with updateCurrUserData");
        return null;
      }

      ///Profile Pic Upload
      if (userNewData.getImageFile != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child(imagePathFolder)
            .child(user.uid + '.jpg');
        await ref
            .putFile(
              userNewData.imageFile,
            )
            .onComplete;
        print('File Uploaded');

        final url = await ref.getDownloadURL();
        if (accountType == AccountTypeChosen.company) {
          userNewData.companyLogo = url;
        } else {
          userNewData.profilePicture = url;
        }
      }

      await dbRef
          .child('Users')
          .child(type)
          .child(user.uid)
          .update(userNewData.toJson());
    } on Exception catch (error) {
      throw error;
    }
    notifyListeners();
  }

  /// deleteCurrUserData
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

  Future<void> _saveDeviceToken() async {
    // Get the token for this device
    String fcmToken = await _fcm.getToken();
    String path;
    if (accountType == AccountTypeChosen.company) {
      path = 'Company Accounts';
    } else if (accountType == AccountTypeChosen.personal) {
      path = 'Personal Accounts';
    }
    // Save it to Firestore
    try {
      if (fcmToken != null) {
        await dbRef
            .child('Users')
            .child(path)
            .child(user.uid)
            .child('token')
            .set(fcmToken);
      }
    } catch (err) {
      throw err;
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
