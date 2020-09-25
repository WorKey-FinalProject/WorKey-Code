import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:workey/general/models/feed_model.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/models/shift_model.dart';
import 'package:workey/general/models/work_group_model.dart';

import 'package:flutter/foundation.dart';

class CompanyGroups with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId;

  List<FeedModel> _feedList = [];
  List<WorkGroupModel> _workGroupsList = [];
  List<GroupEmployeeModel> _employeeList = [];

  FeedModel feedModel = FeedModel(
    title: null,
  );

  WorkGroupModel workGroupModel = WorkGroupModel(
      workGroupName: null,
      managerId: null,
      parentWorkGroupId: null,
      dateOfCreation: null,
      workGroupLogo: null);

  GroupEmployeeModel groupEmployeeModel = GroupEmployeeModel(
    id: null,
    workGroupId: null,
  );

  List<FeedModel> get getFeedList {
    return [..._feedList];
  }

  List<WorkGroupModel> get getWorkGroupsList {
    return [..._workGroupsList];
  }

  List<GroupEmployeeModel> get getWorkGroupEmployeeList {
    return [..._employeeList];
  }

  FeedModel findFeedById(String id) {
    return _feedList.firstWhere((feed) => feed.id == id);
  }

  WorkGroupModel findWorkGroupById(String id) {
    return _workGroupsList.firstWhere((workGroup) => workGroup.id == id);
  }

  GroupEmployeeModel findEmployeeById(String id) {
    return _employeeList.firstWhere((employee) => employee.id == id);
  }

  List<GroupEmployeeModel> _getWorkGroupEmployeeListById(String workGroupId) {
    List<GroupEmployeeModel> list = [];
    _employeeList.forEach((employee) {
      if (employee.workGroupId == workGroupId) {
        list.add(employee);
      }
    });
    return list;
  }

  Future<void> setHourlyWage(ShiftModel shiftModel) async {
    shiftModel.hourlyWage = double.parse(_employeeList
        .firstWhere((employee) => employee.id == shiftModel.id)
        .salary);
  }

  Future<void> getUserId() async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      _userId = user.uid;
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> clearLists() async {
    _feedList = [];
    _workGroupsList = [];
    _employeeList = [];
  }

  Future<void> fetchAndSetToLists() async {
    User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    clearLists();
    await _fetchAndSetToListHandler('feedList');
    await _fetchAndSetToListHandler('empolyeeList');
    await _fetchAndSetToListHandler('workGroupsList');
  }

  Future<void> _fetchAndSetToListHandler(String name) async {
    try {
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child(name)
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> list = dataSnapshot.value;
        if (list != null) {
          if (name == 'feedList') {
            list.forEach((key, value) {
              FeedModel feed = FeedModel(title: null);
              feed.fromJsonToObject(value, key);
              _feedList.add(feed);
            });
          } else if (name == 'empolyeeList') {
            list.forEach((key, value) {
              GroupEmployeeModel emp =
                  GroupEmployeeModel(id: null, workGroupId: null);
              emp.fromJsonToObject(value, key);
              _employeeList.add(emp);
            });
          } else if (name == 'workGroupsList') {
            list.forEach((key, value) {
              WorkGroupModel wg = WorkGroupModel(
                  workGroupName: null,
                  managerId: null,
                  parentWorkGroupId: null,
                  dateOfCreation: null,
                  workGroupLogo: null);
              wg.fromJson(value, key);
              wg.employeeList = _getWorkGroupEmployeeListById(wg.id);
              _workGroupsList.add(wg);
            });
          } else {
            throw 'Error in fatchAndSetToListHandler function';
          }
          notifyListeners();
        }
      });
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> updateFeedInFirebaseAndList(List<FeedModel> newFeedList) async {
    try {
      var db = _dbRef.child('Company Groups').child(_userId).child('feedList');
      await db.remove();
      if (newFeedList.isNotEmpty) {
        newFeedList.forEach((feed) {
          if (feed.id == null) {
            String newKey = db.push().key;
            db.child(newKey).set(feed.toJson());
            feed.id = newKey;
          } else {
            db.child(feed.id).set(feed.toJson());
          }
        });
      } else {
        throw 'the list is empty';
      }
      _feedList = newFeedList;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> addToFirebaseAndList(dynamic model) async {
    try {
      var db = _dbRef.child('Company Groups').child(_userId);
      if (model is WorkGroupModel) {
        db.child('workGroupsList');
        String newKey = db.push().key;
        await db.child(newKey).set(model.toJson());
        model.id = newKey;
        _workGroupsList.add(model);
      } else if (model is GroupEmployeeModel) {
        db.child('empolyeeList').child(model.id).set(model.toJson());
        _employeeList.add(model);
      } else {
        throw 'Error in addToFirebaseAndList function';
      }
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> updateInFirebaseAndList(dynamic model) async {
    try {
      var db = _dbRef.child('Company Groups').child(_userId);
      if (model is WorkGroupModel) {
        db.child('workGroupsList');
        _workGroupsList[_workGroupsList
            .indexWhere((workGroup) => workGroup.id == model.id)] = model;
      } else if (model is GroupEmployeeModel) {
        db.child('empolyeeList');
        _employeeList[_employeeList
            .indexWhere((employee) => employee.id == model.id)] = model;
      } else {
        throw 'Error in updateInFirebaseAndList function';
      }
      db.child(model.id).update(model.toJson());
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> deleteEmployeeById(String employeeId) async {
    try {
      await _dbRef
          .child("Company Groups")
          .child(_userId)
          .child('empolyeeList')
          .child(employeeId)
          .remove();
      _employeeList.removeWhere((employee) => employee.id == employeeId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> deleteWorkGroupById(String workGroupId) async {
    try {
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child('workGroupsList')
          .child(workGroupId)
          .remove();
      _workGroupsList.removeWhere((workGroup) => workGroup.id == workGroupId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  /*
  Future<void> addEmployeeToFirebaseAndList(
      GroupEmployeeModel groupEmployeeModel) async {
    try {
      dbRef
          .child('Company Groups')
          .child(userId)
          .child('empolyeeList')
          .child(groupEmployeeModel.id)
          .set(groupEmployeeModel.toJson());
      employeeList.add(groupEmployeeModel);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> addWorkGroupToFirebaseAndList(
      WorkGroupModel workGroupModel) async {
    var db =
        dbRef.child('Company Groups').child(userId).child('workGroupsList');
    try {
      String newKew = db.push().key;
      await db.child(newKew).set(workGroupModel.toJson());
      workGroupModel.id = newKew;
      workGroupsList.add(workGroupModel);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }
  */

  /*
  Future<void> updateEmployee(GroupEmployeeModel groupEmployeeModel) async {
    try {
      dbRef
          .child('Company Groups')
          .child(userId)
          .child('empolyeeList')
          .child(groupEmployeeModel.id)
          .update(groupEmployeeModel.toJson());
      employeeList[employeeList
              .indexWhere((employee) => employee.id == groupEmployeeModel.id)] =
          groupEmployeeModel;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> updateWorkGroup(WorkGroupModel workGroupModel) async {
    try {
      dbRef
          .child('Company Groups')
          .child(userId)
          .child('workGroupsList')
          .child(workGroupModel.id)
          .update(workGroupModel.toJson());
      workGroupsList[workGroupsList.indexWhere(
          (workGroup) => workGroup.id == workGroupModel.id)] = workGroupModel;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }
  */
}
