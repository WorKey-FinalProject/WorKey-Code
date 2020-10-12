import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:workey/general/models/group_employee_model.dart';

class WorkGroupModel {
  String id;
  String workGroupName;
  String managerId;
  String dateOfCreation;
  String location;
  String logo;
  String whatsAppUrl = '';
  List<GroupEmployeeModel> employeeList;

  File imageFile;

  final dbRef = FirebaseDatabase.instance.reference();

  WorkGroupModel({
    this.id,
    @required this.workGroupName,
    this.managerId,
    @required this.dateOfCreation,
    @required this.logo,
    this.employeeList,
    this.location,
    this.whatsAppUrl = '',
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
      'workGroupLogo': this.logo,
      'workGroupLocation': this.location,
      'employeeList': this.employeeList,
      'whatsAppUrl': this.whatsAppUrl,
    };
  }

  void fromJson(Map snapshot, String uid) {
    id = uid;
    workGroupName = snapshot['workGroupName'];
    managerId = snapshot['managerId'];
    logo = snapshot['workGroupLogo'];
    dateOfCreation = snapshot['dateOfCreation'];
    employeeList = snapshot['employeeList'] ?? null;
    whatsAppUrl = snapshot['whatsAppUrl'] ?? '';
  }
}
