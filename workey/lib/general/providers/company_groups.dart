import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/models/work_group_model.dart';

import 'package:flutter/foundation.dart';

class CompanyGroups with ChangeNotifier {
  List<WorkGroupModel> workGroupsList = [];
  List<GroupEmployeeModel> employeeList = [];
  WorkGroupModel workGroupModel = WorkGroupModel(
      workGroupName: null,
      managerId: null,
      parentWorkGroupId: null,
      dateOfCreation: null,
      workGroupLogo: null);

  final dbRef = FirebaseDatabase.instance.reference();
  String userId;

  List<WorkGroupModel> get getWorkGroupsList {
    return [...workGroupsList];
  }

  List<GroupEmployeeModel> get getWorkGroupEmployeeList {
    return [...employeeList];
  }

  WorkGroupModel findWorkGroupById(String id) {
    return workGroupsList.firstWhere((workGroup) => workGroup.id == id);
  }

  GroupEmployeeModel findEmployeeById(String id) {
    return employeeList.firstWhere((employee) => employee.id == id);
  }

  /*
  Future<void> fatchAndSetEmployeesInList() async {
    try{
      await dbRef
      .child('Company Groups')
      .child(userId)
      .child(path)
    } on Exception {
      throw ErrorHint;
    }
  }
  */

  Future<void> fatchAndSetWorkGroupsInList() async {
    try {
      await dbRef
          .child('Company Groups')
          .child(userId)
          .child('workGroupsList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> list = dataSnapshot.value;
        list.forEach((key, value) {
          workGroupModel.fromJson(value, key);
          workGroupsList.add(workGroupModel);
        });
        notifyListeners();
      });
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> getUserId() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userId = user.uid;
      fatchAndSetWorkGroupsInList();
    } on Exception {
      throw ErrorHint;
    }
    print(employeeList.length);
  }

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

  Future<void> updateWorkGroup(
      String workGroupToUpdateId, WorkGroupModel workGroupModel) async {
    try {
      dbRef
          .child("Company Groups")
          .child(userId)
          .child('workGroupsList')
          .child(workGroupToUpdateId)
          .update(workGroupModel.toJson());
      workGroupsList[workGroupsList.indexWhere(
          (workGroup) => workGroup.id == workGroupToUpdateId)] = workGroupModel;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> deleteWorkGroupById(String workGroupId) async {
    try {
      await dbRef
          .child("Company Groups")
          .child(userId)
          .child('workGroupsList')
          .child(workGroupId)
          .remove();
      workGroupsList.removeWhere((workGroup) => workGroup.id == workGroupId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }
}
