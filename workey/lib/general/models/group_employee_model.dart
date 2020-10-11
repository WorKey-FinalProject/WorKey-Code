import 'package:flutter/foundation.dart';

class GroupEmployeeModel {
  String id;
  String workGroupId;
  String salary;
  String role;
  String firstName;
  String lastName;
  DateTime entryDate;
  String phoneNumber;
  String address;
  String picture;
  String email;
  bool isWorking = false;

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
    this.picture = '',
    this.email,
    this.isWorking,
  });

  Map<String, Object> toJson() {
    String entryDate;
    if (this.entryDate != null) {
      entryDate = this.entryDate.toString();
    }
    return {
      'workGroupId': this.workGroupId,
      'salary': this.salary,
      'role': this.role,
      'entryDate': entryDate ?? this.entryDate,
      'isWorking': isWorking,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    workGroupId = snapshot['workGroupId'];
    salary = snapshot['salary'] ?? '';
    role = snapshot['role'] ?? '';
    entryDate = DateTime.parse(snapshot['entryDate']) ?? '';
    isWorking = snapshot['isWorking'] ?? false;
  }

  void updateGroupEmployee(GroupEmployeeModel groupEmployeeModel) {
    this.workGroupId = groupEmployeeModel.workGroupId;
    this.salary = groupEmployeeModel.salary;
    this.role = groupEmployeeModel.role;
  }
}
