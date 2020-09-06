import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workey/general/models/work_group_model.dart';
import '../models/company_account_model.dart';
import '../models/personal_account_model.dart';
import 'package:workey/general/widgets/auth/signup_type.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference();

  String userId;
  AccountTypeChosen accountType;

  CompanyAccountModel companyUserModel = CompanyAccountModel(
      companyEmail: null,
      companyName: null,
      owenrFirstName: null,
      owenrLastName: null,
      dateOfCreation: null);

  PersonalAccountModel personalUserModel = PersonalAccountModel(
    email: null,
    dateOfCreation: null,
    firstName: null,
    lastName: null,
  );

  Future<void> signUpPersonalAccount(
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
  ) async {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    personalUserModel = PersonalUserModel(
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
    try {
      await dbRef
          .child('Users')
          .child('Personal Accounts')
          .child(authResult.user.uid)
          .set(personalUserModel.toJson());
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> signUpCompanyAccount(
    String companyEmail,
    String password,
    String companyName,
    String location,
    String companyLogo,
    String owenrFirstName,
    String owenrLastName,
  ) async {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: companyEmail,
      password: password,
    );

    companyUserModel = CompanyAccountModel(
        id: authResult.user.uid,
        companyEmail: companyEmail,
        companyName: companyName,
        owenrFirstName: owenrFirstName,
        owenrLastName: owenrLastName,
        dateOfCreation: DateTime.now().toString(),
        companyLogo: companyLogo,
        location: location);

    WorkGroupModel workGroupModel = WorkGroupModel(
      workGroupName: 'Root',
      managerId: null,
      parentWorkGroupId: null,
      dateOfCreation: DateTime.now().toString(),
      workGroupLogo: null,
    );

    try {
      await dbRef
          .child('Users')
          .child('Company Accounts')
          .child(authResult.user.uid)
          .set(companyUserModel.toJson());
    } on Exception {
      throw ErrorHint;
    }
    try {
      await dbRef
          .child('Company Groups')
          .child(authResult.user.uid)
          .set(workGroupModel.toJson());
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> signup(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // if (accountTypeChosen == AccountTypeChosen.company) {
    //   companyUserModel = CompanyAccountModel(
    //     id: authResult.user.uid,
    //     companyEmail: email,
    //     companyName: 'companyName',
    //     owenrFirstName: firstName,
    //     owenrLastName: lastName,
    //     dateOfCreation: DateTime.now().toString(),
    //   );
    //   WorkGroupModel workGroupModel = WorkGroupModel(
    //     workGroupName: 'Root',
    //     managerId: null,
    //     parentWorkGroupId: null,
    //     dateOfCreation: DateTime.now().toString(),
    //     workGroupLogo: null,
    //   );
    //   try {
    //     await dbRef
    //         .child('Users')
    //         .child('Company Accounts')
    //         .child(authResult.user.uid)
    //         .set(companyUserModel.toJson());
    //   } on Exception {
    //     throw ErrorHint;
    //   }
    //   try {
    //     await dbRef
    //         .child('Company Groups')
    //         .child(authResult.user.uid)
    //         .set(workGroupModel.toJson());
    //   } on Exception {
    //     throw ErrorHint;
    //   }
    // }
    // if (accountTypeChosen == AccountTypeChosen.personal) {
    //   personalUserModel = PersonalUserModel(
    //     id: authResult.user.uid,
    //     email: email,
    //     firstName: firstName,
    //     lastName: lastName,
    //     dateOfCreation: DateTime.now().toString(),
    //   );
    //   await dbRef
    //       .child('Users')
    //       .child('Personal Accounts')
    //       .child(authResult.user.uid)
    //       .set(personalUserModel.toJson());
    // }
  }

  Future<void> signin(String email, String password) async {
    AuthResult authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    userId = authResult.user.uid;
    findCurrAccountType();
  }

  Future<void> findCurrAccountType() async {
    await dbRef
        .child('Users')
        .child('Personal Accounts')
        .orderByKey()
        .equalTo(userId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value == null) {
        dbRef
            .child('Users')
            .child('Company Accounts')
            .orderByKey()
            .equalTo(userId)
            .once()
            .then((DataSnapshot dataSnapshot) {
          if (dataSnapshot.value == null) {
            accountType = AccountTypeChosen.nothing;
          } else {
            accountType = AccountTypeChosen.company;
          }
        });
      } else {
        accountType = AccountTypeChosen.personal;
      }
    });
  }

  Future<void> updateCurrUserData(dynamic userNewData) async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      String type;
      if (accountType == AccountTypeChosen.company) {
        type = 'Company Accounts';
        user.updateEmail(userNewData.companyEmail);
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
          .child(userId)
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
      await dbRef.child('Users').child(type).child(userId).remove();
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.delete();
    } on Exception catch (error) {
      throw ErrorHint;
    }
  }
}
