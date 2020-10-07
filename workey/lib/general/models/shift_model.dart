import 'package:flutter/foundation.dart';

class ShiftModel {
  String id;
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
    @required this.startTime,
    @required this.endTime,
    this.hourlyWage,
    @required this.totalHours,
    this.totalWage,
    this.location,
  });

  Map<String, Object> toJson() {
    return {
      'startTime': this.startTime.toString(),
      'endTime': this.endTime.toString(),
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    startTime = DateTime.parse(snapshot['startTime']);
    endTime = DateTime.parse(snapshot['endTime']);
  }

  void updateShift(ShiftModel shiftModel) {
    this.startTime = shiftModel.startTime;
    this.endTime = shiftModel.endTime;
  }
}
