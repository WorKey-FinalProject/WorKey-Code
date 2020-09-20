import 'package:flutter/foundation.dart';

class ShiftModel {
  String id;
  String startTime;
  String endTime;
  double hourlyWage;
  String totalHours;
  String totalMoney;
  String location;

  ShiftModel({
    this.id,
    @required this.startTime,
    @required this.endTime,
    this.hourlyWage,
    this.totalHours,
    this.totalMoney,
    this.location,
  });

  Map<String, Object> toJson() {
    return {
      'startTime': this.startTime,
      'endTime': this.endTime,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    startTime = snapshot['startTime'];
    endTime = snapshot['endTime'] ?? '';
  }

  void updateShift(ShiftModel shiftModel) {
    this.startTime = shiftModel.startTime;
    this.endTime = shiftModel.endTime;
  }
}
