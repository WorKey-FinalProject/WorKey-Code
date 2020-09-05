import 'package:firebase_database/firebase_database.dart';
import 'package:workey/general/models/work_group_model.dart';

import 'package:flutter/foundation.dart';

class CompanyGroups with ChangeNotifier {
  String id;
  String companyName;
  List<WorkGroupModel> workGroupsList;
  String dateOfCration;

  final dbRef = FirebaseDatabase.instance.reference();

  CompanyGroups({
    @required this.dateOfCration,
    @required this.companyName,
    this.workGroupsList,
  });

  Map<String, Object> toJson() {
    return {
      'dateOfCration': this.dateOfCration,
      'companyName': this.companyName,
      'workGroupsList': this.workGroupsList,
    };
  }

  void fromJson(Map snapshot, String uid) {
    id = uid;
    dateOfCration = snapshot['dateOfCration'];
    companyName = snapshot['companyName'];
    workGroupsList = snapshot['workGroupsList'] ?? '';
  }

  List<WorkGroupModel> get getWorkGroupsList {
    return [...workGroupsList];
  }

  WorkGroupModel findWorkGroupById(String id) {
    return workGroupsList.firstWhere((workGroup) => workGroup.id == id);
  }

  // need to check if works
  void addWorkGroupToList(String companyId, WorkGroupModel workGroupModel) {
    try {
      workGroupsList.add(workGroupModel);
      addWorkGroupToListInDatabase(companyId, workGroupModel);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  // need to check if works
  void addWorkGroupToListInDatabase(
      String companyId, WorkGroupModel workGroupModel) async {
    try {
      await dbRef
          .child("Company")
          .child(companyId)
          .child('workGroupsList')
          .set(workGroupModel.toJson());
    } on Exception {
      throw ErrorHint;
    }
  }

  // need to check if works
  void deleteWorkGroupFromListById(String companyId, String workGroupId) {
    try {
      workGroupsList.removeWhere((workGroup) => workGroup.id == id);
      deleteWorkGroupByIdInDatabase(companyId, workGroupId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  // need to check if works
  void deleteWorkGroupByIdInDatabase(
      String companyId, String workGroupId) async {
    try {
      await dbRef
          .child("Company")
          .child(companyId)
          .child('workGroupsList')
          .child(workGroupId)
          .remove();
    } on Exception {
      throw ErrorHint;
    }
  }

  void updateCompanyName(String id, String companyName) {
    try {
      this.companyName = companyName;
      updateCompanyNameInDatabase(id, companyName);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  void updateCompanyNameInDatabase(String id, String companyName) async {
    try {
      await dbRef
          .child("Company")
          .child(id)
          .update({'companyName': companyName});
    } on Exception {
      throw ErrorHint;
    }
  }
}
