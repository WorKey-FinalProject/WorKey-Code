import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:workey/general/models/group_employee_model.dart';

class WorkGroupModel {
  String id;
  String workGroupName;
  String managerId;
  String dateOfCreation;
  String workGroupLocation;
  String workGroupLogo;
  List<GroupEmployeeModel> employeeList;
  List<WorkGroupModel> workGroupList;

  File imageFile;

  final dbRef = FirebaseDatabase.instance.reference();

  WorkGroupModel({
    this.id,
    @required this.workGroupName,
    this.managerId,
    @required this.dateOfCreation,
    @required this.workGroupLogo,
    this.employeeList,
    this.workGroupLocation,
  });

  void setImageFile(File file) {
    imageFile = file;
  }

  File get getImageFile {
    return imageFile;
  }

  Map<String, Object> toJson() {
    return {
      'workGroupName': this.workGroupName,
      'managerId': this.managerId,
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
    workGroupLogo = snapshot['workGroupLogo'];
    dateOfCreation = snapshot['dateOfCreation'];
    employeeList = snapshot['employeeList'] ?? null;
    workGroupLocation = snapshot['workGroupLocation'] ?? '';
  }
}
