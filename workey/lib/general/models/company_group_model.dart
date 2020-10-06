import 'package:flutter/foundation.dart';

class CompanyGroupModel {
  String id;
  String feedList;
  String employeeList;
  String workGroupList;
  String shiftList;

  CompanyGroupModel({
    @required this.id,
    this.feedList,
    this.employeeList,
    this.workGroupList,
    this.shiftList,
  });

  Map<String, Object> toJson() {
    return {
      'employeeList': this.employeeList,
      'feedList': this.feedList,
      'workGroupList': this.workGroupList,
      'shiftList': this.shiftList,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    employeeList = snapshot['employeeList'] ?? '';
    feedList = snapshot['feedList'] ?? '';
    workGroupList = snapshot['workGroupList'] ?? '';
    shiftList = snapshot['shiftList'] ?? '';
  }
}
