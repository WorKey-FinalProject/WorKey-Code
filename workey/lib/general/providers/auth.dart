import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workey/general/models/company_user_model.dart';
import 'package:workey/general/models/personal_user_model.dart';
import 'package:workey/general/widgets/auth/signup_form.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference();

  String userId;
  AccountTypeChosen accountType;

  CompanyUserModel companyUserModel = CompanyUserModel(
      companyEmail: null,
      companyName: null,
      owenrFirstName: null,
      owenrLastName: null,
      dateOfCreation: null);
  PersonalUserModel personalUserModel = PersonalUserModel(
    email: null,
    dateOfCreation: null,
    firstName: null,
    lastName: null,
  );

  var value;

  Future<void> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    AccountTypeChosen accountTypeChosen,
  ) async {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (accountTypeChosen == AccountTypeChosen.company) {
      /*
      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData(
        {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
        },
      );
      */
      companyUserModel = CompanyUserModel(
        id: authResult.user.uid,
        companyEmail: email,
        companyName: 'companyName',
        owenrFirstName: firstName,
        owenrLastName: lastName,
        dateOfCreation: DateTime.now().toString(),
      );
      await dbRef
          .child('Users')
          .child('Company Accounts')
          .child(authResult.user.uid)
          .set(companyUserModel.toJson());
    }
    if (accountTypeChosen == AccountTypeChosen.personal) {
      // await Firestore.instance
      //     .collection('users')
      //     .document(authResult.user.uid)
      //     .setData(
      //   {
      //     'email': email,
      //     'firstName': firstName,
      //     'lastName': lastName,
      //   },
      // );
      personalUserModel = PersonalUserModel(
        id: authResult.user.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        dateOfCreation: DateTime.now().toString(),
      );
      await dbRef
          .child('Users')
          .child('Personal Accounts')
          .child(authResult.user.uid)
          .set(personalUserModel.toJson());
    }
  }

  Future<void> signin(String email, String password) async {
    AuthResult authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    userId = authResult.user.uid;
    findCurrAccountType();
    // await Firestore.instance
    //     .collection('users')
    //     .document(authResult.user.uid)
    //     .setData(
    //   {
    //     'email': email,
    //   },
    // );
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
      } else {
        type = 'Personal Accounts';
        user.updateEmail(userNewData.email);
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
