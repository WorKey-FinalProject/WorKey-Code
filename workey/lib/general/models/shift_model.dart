import 'package:flutter/foundation.dart';

class ShiftModel {
  String id;
  String employeeId;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  double hourlyWage;
  double totalHours;
  double totalWage;
  String location;

  ShiftModel({
    this.id,
    this.employeeId,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    this.hourlyWage,
    this.totalHours,
    this.totalWage,
    this.location,
  });

  Map<String, Object> toJson() {
    return {
      'date': this.date.toString(),
      'startTime': this.startTime.toString(),
      'endTime': this.endTime.toString(),
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    date = DateTime.parse(snapshot['date']);
    startTime = DateTime.parse(snapshot['startTime']);
    endTime = DateTime.parse(snapshot['endTime']);
  }

  void updateShift(ShiftModel shiftModel) {
    this.date = shiftModel.date;
    this.startTime = shiftModel.startTime;
    this.endTime = shiftModel.endTime;
  }
}
