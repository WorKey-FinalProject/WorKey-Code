import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:workey/general/models/shift_model.dart';

class Shifts with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId = FirebaseAuth.instance.currentUser.uid;

  List<ShiftModel> _shiftList = [];

  List<ShiftModel> get getShiftList {
    return [..._shiftList];
  }

  ShiftModel findFeedById(String id) {
    return _shiftList.firstWhere((shift) => shift.id == id);
  }

  Future<void> clearList() async {
    _shiftList = [];
  }

  Future<void> fetchAndSetToLists() async {
    clearList();
    try {
      await _dbRef
          .child('Shifts')
          .child(_userId)
          .child('shiftList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> list = dataSnapshot.value;
        if (list != null) {
          list.forEach((key, value) {
            ShiftModel shiftModel = ShiftModel(
              date: null,
              startTime: null,
              endTime: null,
            );
            shiftModel.fromJsonToObject(value, key);
            _shiftList.add(shiftModel);
          });
          notifyListeners();
        }
      });
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> addToFirebaseAndList(ShiftModel shiftModel) async {
    try {
      var db = _dbRef.child('Shifts').child(_userId);
      db.child('shiftList');
      String newKey = db.push().key;
      await db.child(newKey).set(shiftModel.toJson());
      shiftModel.id = newKey;
      _shiftList.add(shiftModel);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> updateInFirebaseAndList(ShiftModel shiftModel) async {
    try {
      await _dbRef
          .child('Shifts')
          .child(_userId)
          .child('shiftList')
          .child(shiftModel.id)
          .update(shiftModel.toJson());
      _shiftList[_shiftList.indexWhere((shift) => shift.id == shiftModel.id)] =
          shiftModel;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

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

  Future<void> shiftSummary(ShiftModel shiftModel) async {
    await _shiftTotalHours(shiftModel);
    await _shiftTotalMoney(shiftModel);
  }

  Future<void> _shiftTotalHours(ShiftModel shiftModel) async {
    try {
      DateTime start = DateTime.parse(shiftModel.startTime);
      DateTime end = DateTime.parse(shiftModel.endTime);
      shiftModel.totalHours = end.difference(start).inHours.toString();
    } on Exception {
      ErrorHint;
    }
  }

  Future<void> _shiftTotalMoney(ShiftModel shiftModel) async {
    try {
      shiftModel.totalMoney =
          double.parse(shiftModel.totalHours) * shiftModel.hourlyWage;
    } on Exception {
      ErrorHint;
    }
  }
}
