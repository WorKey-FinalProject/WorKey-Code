import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:workey/general/models/personal_account_model.dart';
import 'package:workey/general/models/shift_model.dart';

class Shifts with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId;

  List<ShiftModel> _shiftList = [];

  List<ShiftModel> get getShiftList {
    return [..._shiftList];
  }

  String get getUserId {
    return _userId;
  }

  ShiftModel findFeedById(String id) {
    return _shiftList.firstWhere((shift) => shift.id == id);
  }

  Future<void> clearList() async {
    _shiftList = [];
  }

  Future<void> fetchAndSetToListForPersonal(String companyId) async {
    User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    clearList();
    try {
      await _dbRef
          .child('Company Groups')
          .child(companyId)
          .child('shiftList')
          .child(_userId)
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> map = dataSnapshot.value;
        if (map != null) {
          map.forEach((key, value) {
            ShiftModel shift = ShiftModel(startTime: null, endTime: null);
            shift.fromJsonToObject(value, key);
            shift.companyId = companyId;
            shift.employeeId = _userId;
            shift.totalHours = (shift.endTime
                    .difference(shift.startTime)
                    .inSeconds
                    .toDouble()) /
                3600;
            shiftSummary(shift);
            _shiftList.add(shift);
          });
        }
      });
    } on Exception {
      throw 'Error in fetchAndSetToListForPersonal() of shifts';
    }
    notifyListeners();
  }

  Future<void> addToFirebaseAndList(ShiftModel shiftModel) async {
    try {
      var db = _dbRef
          .child('Company Groups')
          .child(shiftModel.companyId)
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

  Future<void> shiftSummary(ShiftModel shiftModel) async {
    try {
      _dbRef
          .child('Company Groups')
          .child(shiftModel.companyId)
          .child('employeeList')
          .child(shiftModel.employeeId)
          .once()
          .then((DataSnapshot dataSnapshot) {
        shiftModel.hourlyWage = double.parse(dataSnapshot.value['salary']);
        shiftModel.totalWage = shiftModel.totalHours * shiftModel.hourlyWage;
      });
    } on Exception {
      throw 'Error in _getHourlyWage(String id)';
    }
  }

  Future<void> fetchShiftCompanyIdAndEmployeeId(ShiftModel shiftModel) async {
    try {
      shiftModel.employeeId = _userId;
      await _dbRef
          .child('Users')
          .child('Personal Accounts')
          .child(shiftModel.employeeId)
          .once()
          .then((DataSnapshot dataSnapshot) {
        PersonalAccountModel p = PersonalAccountModel(
            email: null, firstName: null, lastName: null, dateOfCreation: null);
        p.fromJsonToObject(dataSnapshot.value, _userId);
        shiftModel.companyId = p.companyId;
      });
    } on Exception {
      throw 'Error in _fetchShiftCompanyId function of Shifts';
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
