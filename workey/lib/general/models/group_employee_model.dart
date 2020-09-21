import 'package:flutter/foundation.dart';

class GroupEmployeeModel {
  String id;
  String workGroupId;
  bool monthSalary;
  String salary;
  String role;

  GroupEmployeeModel({
    @required this.id,
    @required this.workGroupId,
    this.monthSalary,
    this.salary,
    this.role,
  });

  Map<String, Object> toJson() {
    return {
      'workGroupId': this.workGroupId,
      'salary': this.salary,
      'role': this.role,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    workGroupId = snapshot['workGroupId'];
    salary = snapshot['salary'] ?? '';
    role = snapshot['role'] ?? '';
  }

  void updateGroupEmployee(GroupEmployeeModel groupEmployeeModel) {
    this.workGroupId = groupEmployeeModel.workGroupId;
    this.salary = groupEmployeeModel.salary;
    this.role = groupEmployeeModel.role;
  }
}
