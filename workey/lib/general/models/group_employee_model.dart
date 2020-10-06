import 'package:flutter/foundation.dart';

class GroupEmployeeModel {
  String id;
  String workGroupId;
  String salary;
  String role;
  String firstName;
  String lastName;
  String entryDate;
  String phoneNumber;
  String address;
  String picture;
  String email;

  GroupEmployeeModel({
    @required this.id,
    @required this.workGroupId,
    this.salary,
    this.role,
    this.firstName,
    this.lastName,
    this.entryDate,
    this.phoneNumber,
    this.address,
    this.picture,
    this.email,
  });

  Map<String, Object> toJson() {
    return {
      'workGroupId': this.workGroupId,
      'salary': this.salary,
      'role': this.role,
      'entryDate': this.entryDate,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    workGroupId = snapshot['workGroupId'];
    salary = snapshot['salary'] ?? '';
    role = snapshot['role'] ?? '';
    entryDate = snapshot['entryDate'] ?? '';
  }

  void updateGroupEmployee(GroupEmployeeModel groupEmployeeModel) {
    this.workGroupId = groupEmployeeModel.workGroupId;
    this.salary = groupEmployeeModel.salary;
    this.role = groupEmployeeModel.role;
  }
}
