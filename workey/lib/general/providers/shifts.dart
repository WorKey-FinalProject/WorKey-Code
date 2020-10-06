import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:workey/general/models/shift_model.dart';

class Shifts with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId = FirebaseAuth.instance.currentUser.uid;
  String _currentCompanyId;

  List<ShiftModel> _shiftList = [];

  List<ShiftModel> get getShiftList {
    return [..._shiftList];
  }

  Future<void> setCurrentCompanyId(String companyId) async {
    _currentCompanyId = companyId;
  }

  ShiftModel findFeedById(String id) {
    return _shiftList.firstWhere((shift) => shift.id == id);
  }

  Future<void> clearList() async {
    _shiftList = [];
  }

  Future<void> addToFirebaseAndList(ShiftModel shiftModel) async {
    try {
      var db = _dbRef
          .child('Company Groups')
          .child(_currentCompanyId)
          .child('shiftList')
          .child(_userId);
      String newKey = db.push().key;
      await db.child(newKey).set(shiftModel.toJson());
      shiftModel.id = newKey;
      _shiftList.add(shiftModel);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> shiftSummary(ShiftModel shiftModel, String companyId) async {
    try {
      _dbRef
          .child('Company Groups')
          .child(companyId)
          .child('employeeList')
          .child(shiftModel.employeeId)
          .once()
          .then((DataSnapshot dataSnapshot) {
        shiftModel.hourlyWage = double.parse(dataSnapshot.value['salary']);
        DateTime start = shiftModel.startTime;
        DateTime end = shiftModel.endTime;
        shiftModel.totalHours = end.difference(start).inMinutes.toDouble() / 60;
        shiftModel.totalWage = shiftModel.totalHours * shiftModel.hourlyWage;
      });
    } on Exception {
      throw 'Error in _getHourlyWage(String id)';
    }
  }
  /*
  Future<void> updateInFirebaseAndList(ShiftModel shiftModel, String companyId) async {
    try {
      await _dbRef
          .child('Company Groups')
          .child(companyId)
          .child('shiftList')
          .child(_userId)
          .child(shiftModel.id)
          .update(shiftModel.toJson());
      _shiftList[_shiftList.indexWhere((shift) => shift.id == shiftModel.id)] =
          shiftModel;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }
  */

  /*
  Future<void> deleteShiftById(String shiftId) async {
    try {
      await _dbRef
          .child("Shifts")
          .child(_userId)
          .child('shiftList')
          .child(shiftId)
          .remove();
      _shiftList.removeWhere((shift) => shift.id == shiftId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }
  */

}
