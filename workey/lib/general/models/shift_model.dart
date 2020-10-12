import 'package:flutter/foundation.dart';

class ShiftModel {
  String id;
  String companyId;
  String employeeId;
  DateTime startTime;
  DateTime endTime;
  double hourlyWage;
  double totalHours;
  double totalWage;
  String location;

  ShiftModel({
    this.id,
    this.employeeId,
    this.companyId,
    @required this.startTime,
    @required this.endTime,
    this.hourlyWage,
    this.totalHours,
    this.totalWage,
    this.location,
  });

  Map<String, Object> toJson() {
    return {
      'hourlyWage': this.hourlyWage.toString(),
      'startTime': this.startTime.toString(),
      'endTime': this.endTime.toString(),
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    hourlyWage = double.parse(snapshot['hourlyWage']);
    startTime = DateTime.parse(snapshot['startTime']);
    endTime = DateTime.parse(snapshot['endTime']);
  }

  void updateShift(ShiftModel shiftModel) {
    this.startTime = shiftModel.startTime;
    this.endTime = shiftModel.endTime;
  }
}
