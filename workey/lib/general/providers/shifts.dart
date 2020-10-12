import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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

  Future<void> fetchAndSetToListForCompany() async {
    User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    clearList();
    try {
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child('shiftList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> map = dataSnapshot.value;
        if (map != null) {
          map.forEach((key, value) {
            Map<dynamic, dynamic> map2 = value;
            map2.forEach((key2, value2) {
              ShiftModel shiftModel =
                  ShiftModel(startTime: null, endTime: null);
              shiftModel.fromJsonToObject(value2, key2);
              shiftModel.companyId = _userId;
              shiftModel.employeeId = key;
              shiftModel.totalHours = (shiftModel.endTime
                      .difference(shiftModel.startTime)
                      .inSeconds
                      .toDouble()) /
                  3600;
              shiftSummary(shiftModel);
              _shiftList.add(shiftModel);
            });
          });
        }
      });
    } catch (err) {
      throw 'Error in fetchAndSetToListForCompany() of shifts';
    }
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

  Future<ShiftModel> _buildShiftObject(
      DateTime start, DateTime end, int seconds) async {
    ShiftModel shiftModel = ShiftModel(
      startTime:
          DateTime.parse(DateFormat('yyyy-MM-dd kk:mm:ss').format(start)),
      endTime: DateTime.parse(DateFormat('yyyy-MM-dd kk:mm:ss').format(end)),
      totalHours: seconds / 3600,
    );
    if (_shiftList.isEmpty) {
      await fetchShiftCompanyIdAndEmployeeId(shiftModel);
    } else {
      shiftModel.companyId = _shiftList[0].companyId;
      shiftModel.employeeId = _shiftList[0].employeeId;
    }
    shiftSummary(shiftModel);
    return shiftModel;
  }

  Future<void> addShiftToFirebaseAndList(
      DateTime start, DateTime end, int seconds) async {
    ShiftModel shift = await _buildShiftObject(start, end, seconds);
    try {
      var db = _dbRef
          .child('Company Groups')
          .child(shift.companyId)
          .child('shiftList')
          .child(_userId);
      String newKey = db.push().key;
      await db.child(newKey).set(shift.toJson());
      shift.id = newKey;
      _shiftList.add(shift);
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

            email: null,
            firstName: null,
            lastName: null,
            dateOfCreation: null,
            token: '',);

        p.fromJsonToObject(dataSnapshot.value, _userId);
        shiftModel.companyId = p.companyId;
      });
    } on Exception {
      throw 'Error in _fetchShiftCompanyId function of Shifts';
    }
  }
}
