import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:workey/general/models/monthly_shift_summery_model.dart';
import 'package:workey/general/models/shift_model.dart';

class MonthltShiftSummeryList with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId;
  String _companyId;

  List<MonthlyShiftSummeryModel> _monthlyShiftSummeryList = [];

  List<MonthlyShiftSummeryModel> get getFeedList {
    return [..._monthlyShiftSummeryList];
  }

  Future<void> clearList() async {
    _monthlyShiftSummeryList = [];
  }

  Future<void> fetchAndSetToListForCompany() async {
    User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    _companyId = user.uid;
    clearList();
    try {
      _dbRef
          .child('Company Groups')
          .child(_companyId)
          .child('shiftList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> map = dataSnapshot.value;
        if (map.isNotEmpty) {
          map.keys.forEach((key) {
            fetchAndSetToListForPersonal(_companyId, key);
          });
        }
      });
    } on Exception {
      throw 'Error in fetchAndSetToList';
    }
  }

  Future<void> fetchAndSetToListForPersonal(
      String companyId, String employeeId) async {
    User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    _companyId = companyId;
    clearList();
    List<ShiftModel> list = [];
    try {
      await _dbRef
          .child('Company Groups')
          .child(companyId)
          .child('shiftList')
          .child(employeeId)
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> map = dataSnapshot.value;
        if (map != null) {
          if (map.isNotEmpty) {
            map.forEach((key, value) {
              ShiftModel shiftModel =
                  ShiftModel(startTime: null, endTime: null);
              shiftModel.fromJsonToObject(value, key);
              shiftModel.companyId = companyId;
              shiftModel.employeeId = employeeId;
              shiftModel.totalHours = (shiftModel.endTime
                      .difference(shiftModel.startTime)
                      .inSeconds
                      .toDouble()) /
                  3600;
              shiftModel.totalWage =
                  shiftModel.totalHours * shiftModel.hourlyWage;
              list.add(shiftModel);
            });
            MonthlyShiftSummeryModel model =
                MonthlyShiftSummeryModel(shiftList: list);
            double hours = 0;
            double wage = 0;
            model.shiftList.forEach((shift) {
              hours += shift.totalHours;
              wage += shift.totalWage;
            });
            model.totalHours = hours;
            model.totalWage = wage;
            _monthlyShiftSummeryList.add(model);
          }
        }
      });
    } on Exception {
      throw 'Error in fetchAndSetToList';
    }
    notifyListeners();
  }

  Future<void> makePaymentByCompany(String employeeId) async {
    MonthlyShiftSummeryModel model = _monthlyShiftSummeryList[
        _monthlyShiftSummeryList.indexWhere(
            (month) => month.shiftList[0].employeeId == employeeId)];
    try {
      var db = _dbRef
          .child('Company Groups')
          .child(_companyId)
          .child('employeeList')
          .child(employeeId)
          .child('monthlyShiftSummeryList');
      String newKey = db.push().key;
      db.child(newKey).set(model.toJson());
      model.id = newKey;
      model.shiftList.forEach((shift) {
        db.child(newKey).child('shifts').child(shift.id).set(shift.toJson());
      });
      _monthlyShiftSummeryList.removeWhere((month) => month.id == model.id);
      notifyListeners();
      _dbRef
          .child('Company Groups')
          .child(_companyId)
          .child('shiftList')
          .child(employeeId)
          .remove();
    } on Exception {
      throw 'Error in makePaymentByCompany';
    }
  }

  // Future<void> addToFirebaseAndList(MonthlyShiftSummeryModel model) async {
  //   double hours = 0;
  //   double wage = 0;
  //   model.shiftList.forEach((shift) {
  //     hours += shift.totalHours;
  //     wage += shift.totalWage;
  //   });
  //   model.totalHours = hours;
  //   model.totalWage = wage;
  //   try {
  //     var db = _dbRef
  //         .child('Company Groups')
  //         .child(_companyId)
  //         .child('employeeList')
  //         .child(_userId)
  //         .child('monthlyShiftSummeryList');
  //     String newKey = db.push().key;
  //     db.child(newKey).set(model.toJson());
  //     model.id = newKey;
  //     model.shiftList.forEach((shift) {
  //       db.child(newKey).child('shifts').child(shift.id).set(shift.toJson());
  //     });
  //   } on Exception {
  //     throw 'Error in addToFirebaseAndList';
  //   }
  //   notifyListeners();
  // }
}
