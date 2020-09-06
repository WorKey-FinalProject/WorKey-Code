import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:workey/general/models/group_employee_model.dart';

class WorkGroupModel {
  String id;
  String workGroupName;
  String managerId;
  String parentWorkGroupId;
  String dateOfCreation;
  String workGroupLocation;
  String workGroupLogo;
  List<GroupEmployeeModel> employeeList;
  List<WorkGroupModel> workGroupList;

  final dbRef = FirebaseDatabase.instance.reference();

  WorkGroupModel({
    this.id,
    @required this.workGroupName,
    @required this.managerId,
    @required this.parentWorkGroupId,
    @required this.dateOfCreation,
    @required this.workGroupLogo,
    this.employeeList,
    this.workGroupLocation,
  });

  Map<String, Object> toJson() {
    return {
      'workGroupName': this.workGroupName,
      'managerId': this.managerId,
      'parentWorkGroupId': this.parentWorkGroupId,
      'dateOfCreation': this.dateOfCreation,
      'workGroupLogo': this.workGroupLogo,
      'workGroupLocation': this.workGroupLocation,
      'employeeList': this.employeeList,
    };
  }

  void fromJson(Map snapshot, String uid) {
    id = uid;
    workGroupName = snapshot['workGroupName'];
    managerId = snapshot['managerId'];
    parentWorkGroupId = snapshot['parentWorkGroupId'];
    workGroupLogo = snapshot['workGroupLogo'];
    dateOfCreation = snapshot['dateOfCreation'];
    employeeList = snapshot['employeeList'] ?? '';
    workGroupLocation = snapshot['workGroupLocation'] ?? '';
  }
}
