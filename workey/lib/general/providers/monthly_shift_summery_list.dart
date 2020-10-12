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

  Future<void> fetchAndSetToList(String companyId) async {
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
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> map = dataSnapshot.value;
        map.forEach((key, value) {
          Map<dynamic, dynamic> map2 = value;
          map2.forEach((key2, value2) {
            ShiftModel shiftModel = ShiftModel(startTime: null, endTime: null);
            shiftModel.fromJsonToObject(value2, key2);
            shiftModel.companyId = _userId;
            shiftModel.employeeId = key;
            shiftModel.totalHours = (shiftModel.endTime
                    .difference(shiftModel.startTime)
                    .inSeconds
                    .toDouble()) /
                3600;
            shiftModel.totalWage =
                shiftModel.totalHours * shiftModel.hourlyWage;
            list.add(shiftModel);
          });
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
      });
    } on Exception {
      throw 'Error in fetchAndSetToList';
    }
    notifyListeners();
  }

  Future<void> addToFirebaseAndList(MonthlyShiftSummeryModel model) async {
    double hours = 0;
    double wage = 0;
    model.shiftList.forEach((shift) {
      hours += shift.totalHours;
      wage += shift.totalWage;
    });
    model.totalHours = hours;
    model.totalWage = wage;
    try {
      var db = _dbRef
          .child('Company Groups')
          .child(_companyId)
          .child('employeeList')
          .child(_userId)
          .child('monthlyShiftSummeryList');
      String newKey = db.push().key;
      db.child(newKey).set(model.toJson());
      model.id = newKey;
      model.shiftList.forEach((shift) {
        db.child(newKey).child('shifts').child(shift.id).set(shift.toJson());
      });
    } on Exception {
      throw 'Error in addToFirebaseAndList';
    }
    notifyListeners();
  }
}
