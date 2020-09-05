import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:workey/general/models/group_employee.dart';

class WorkGroupModel {
  String id;
  String workGroupName;
  String managerId;
  String parentWorkGroupId;
  String dateOfCreation;
  String workGroupLocation;
  List<Employee> employees;
  List<WorkGroupModel> workGroupList;

  final dbRef = FirebaseDatabase.instance.reference();

  WorkGroupModel({
    this.id,
    @required this.workGroupName,
    @required this.managerId,
    @required this.parentWorkGroupId,
    @required this.dateOfCreation,
    this.workGroupLocation,
  });

  Map<String, Object> toJson() {
    return {
      'workGroupName': this.workGroupName,
      'managerId': this.managerId,
      'parentWorkGroupId': this.parentWorkGroupId,
      'dateOfCreation': this.dateOfCreation,
      'workGroupLocation': this.workGroupLocation,
    };
  }

  void fromJson(Map snapshot, String uid) {
    id = uid;
    workGroupName = snapshot['workGroupName'];
    managerId = snapshot['managerId'];
    parentWorkGroupId = snapshot['parentWorkGroupId'];
    dateOfCreation = snapshot['dateOfCreation'];
    workGroupLocation = snapshot['workGroupLocation'] ?? '';
  }
}
