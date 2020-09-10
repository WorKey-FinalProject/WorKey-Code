import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workey/general/models/work_group_model.dart';
import 'package:workey/general/widgets/auth/signup_type.dart';
import '../models/company_account_model.dart';
import '../models/personal_account_model.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference();

  AccountTypeChosen accountType;
  FirebaseUser user;

  CompanyAccountModel companyAccountModel = CompanyAccountModel(
      companyEmail: null,
      companyName: null,
      owenrFirstName: null,
      owenrLastName: null,
      dateOfCreation: null);

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
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
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
    try {
      await dbRef
          .child('Users')
          .child('Personal Accounts')
          .child(authResult.user.uid)
          .set(personalAccountModel.toJson());
    } on Exception {
      throw ErrorHint;
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
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: companyEmail,
      password: password,
    );

    companyAccountModel = CompanyAccountModel(
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
          .set(companyAccountModel.toJson());
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

  Future<AccountTypeChosen> findCurrAccountType(FirebaseUser user) async {
    await dbRef
        .child('Users')
        .child('Personal Accounts')
        .orderByKey()
        .equalTo(user.uid)
        .once()
        .then(
      (DataSnapshot dataSnapshot) async {
        if (dataSnapshot.value == null) {
          await dbRef
              .child('Users')
              .child('Company Accounts')
              .orderByKey()
              .equalTo(user.uid)
              .once()
              .then((DataSnapshot dataSnapshot) {
            if (dataSnapshot.value == null) {
              accountType = AccountTypeChosen.nothing;
            } else {
              accountType = AccountTypeChosen.company;
              print('$accountType ccccooommm');
            }
          });
        } else {
          accountType = AccountTypeChosen.personal;
        }
      },
    );
    //print('$accountType wtffffffffffffffff');
    return accountType;
    //print('${accountType} ----- findCurrAccountType');
  }

  Future<dynamic> getCurrUserData() async {
    try {
      if (accountType == AccountTypeChosen.company) {
        await dbRef
            .child('Users')
            .child('Company Accounts')
            .child(user.uid)
            .once()
            .then((DataSnapshot dataSnapshot) {
          companyAccountModel.fromJson(dataSnapshot.value, user.uid);
          companyAccountModel.id = user.uid;
          return companyAccountModel;
        });
      } else if (accountType == AccountTypeChosen.personal) {
        await dbRef
            .child('Users')
            .child('Personal Accounts')
            .child(user.uid)
            .once()
            .then((DataSnapshot dataSnapshot) {
          personalAccountModel.fromJson(dataSnapshot.value, user.uid);
          personalAccountModel.id = user.uid;
          return personalAccountModel;
        });
      } else {
        throw 'failed to get user data: error - accountType == nothing.';
      }
    } on Exception {
      throw ErrorHint;
    }
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
      FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
      firebaseUser.delete();
    } on Exception {
      throw ErrorHint;
    }
  }
}
