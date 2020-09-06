import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:workey/general/models/work_group_model.dart';

import 'package:flutter/foundation.dart';

class CompanyGroups with ChangeNotifier {
  List<WorkGroupModel> workGroupsList = [];
  WorkGroupModel workGroupModel;

  final dbRef = FirebaseDatabase.instance.reference();
  String userId;

  List<WorkGroupModel> get getWorkGroupsList {
    return [...workGroupsList];
  }

  WorkGroupModel findWorkGroupById(String id) {
    return workGroupsList.firstWhere((workGroup) => workGroup.id == id);
  }

  Future<void> getUserId() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userId = user.uid;
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> addWorkGroup(WorkGroupModel workGroupModel) async {
    var db =
        dbRef.child("Company Groups").child(userId).child('workGroupsList');
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