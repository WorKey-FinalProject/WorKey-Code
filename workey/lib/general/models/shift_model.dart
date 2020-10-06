import 'package:flutter/foundation.dart';

class ShiftModel {
  String id;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  double hourlyWage;
  String totalHours;
  double totalMoney;
  String location;

  ShiftModel({
    this.id,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    this.hourlyWage,
    this.totalHours,
    this.totalMoney,
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
    date = snapshot['date'];
    startTime = snapshot['startTime'];
    endTime = snapshot['endTime'];
  }

  void updateShift(ShiftModel shiftModel) {
    this.date = shiftModel.date;
    this.startTime = shiftModel.startTime;
    this.endTime = shiftModel.endTime;
  }
}
