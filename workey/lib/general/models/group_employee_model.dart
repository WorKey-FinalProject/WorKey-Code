import 'package:flutter/foundation.dart';

class GroupEmployeeModel {
  String id;
  String workGroupId;
  String email;
  String firstName;
  String lastName;
  String profilePicture;
  String salary;
  String role;

  GroupEmployeeModel({
    @required this.id,
    @required this.workGroupId,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    this.profilePicture,
    this.salary,
    this.role,
  });

  Map<String, Object> toJson() {
    return {
      'workGroupId': this.workGroupId,
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'profilePicture': this.profilePicture,
      'salary': this.salary,
      'role': this.role,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    workGroupId = snapshot['workGroupId'];
    email = snapshot['email'];
    firstName = snapshot['firstName'];
    lastName = snapshot['lastName'];
    profilePicture = snapshot['profilePicture'] ?? '';
    salary = snapshot['salary'] ?? '';
    role = snapshot['role'] ?? '';
  }

  void updateGroupEmployee(GroupEmployeeModel groupEmployeeModel) {
    this.workGroupId = groupEmployeeModel.workGroupId;
    this.email = groupEmployeeModel.email;
    this.firstName = groupEmployeeModel.firstName;
    this.lastName = groupEmployeeModel.lastName;
    this.profilePicture = groupEmployeeModel.profilePicture;
    this.salary = groupEmployeeModel.salary;
    this.role = groupEmployeeModel.role;
  }
}
